import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> loginUser(
     {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
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
  }

  Future<void> registerUser(
      {required String email, required String password}) async {
    emit(RegisterLoading());
    try {
      
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
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

  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
  
    print(change) ;
  }
}
