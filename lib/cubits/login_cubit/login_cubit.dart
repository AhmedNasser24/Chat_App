import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
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
}
