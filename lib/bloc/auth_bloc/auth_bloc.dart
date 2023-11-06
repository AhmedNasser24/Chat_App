import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on(
      (event, emit) async {
        if (event is LoginEvent) {
          emit(LoginLoading());
          try {
            await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: event.email, password: event.password);
            emit(LoginSucceed());
          } on FirebaseAuthException catch (e) {
            if (e.code == 'invalid-email') {
              emit(LoginFailure(
                  errorMessage:
                      'invalid email , email should be: email_name@*****.com'));
            } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
              emit(LoginFailure(
                  errorMessage: 'wrong , check your email and password'));
            } else if (e.code == 'network-request-failed') {
              emit(LoginFailure(
                  errorMessage: 'please check your internet connection'));
            } else {
              emit(LoginFailure(errorMessage: 'unknown input'));
            }
          } catch (e) {
            emit(LoginFailure(errorMessage: 'unknown exception'));
          }
        } else if (event is RegisterEvent) {
          emit(RegisterLoading());
          try {
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: event.email,
              password: event.password,
            );
            emit(RegisterSucceed());
          } on FirebaseAuthException catch (e) {
            if (e.code == 'invalid-email') {
              emit(RegisterFailure(
                  'Invalid email , email should be : email_name@*****.com'));
            } else if (e.code == 'weak-password') {
              emit(RegisterFailure('The password provided is too weak'));
            } else if (e.code == 'email-already-in-use') {
              emit(RegisterFailure('This email is already exist'));
            } else if (e.code == 'network-request-failed') {
              emit(RegisterFailure('please check your internet connection'));
            } else {
              emit(RegisterFailure('unknown input'));
            }
          } catch (e) {
            emit(
              RegisterFailure('unknown exception'),
            );
          }
        }
      },
    );
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    super.onTransition(transition);

    print(transition) ;
  }
}
