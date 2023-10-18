import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  Future<void> registerUser(
      {required String email, required String password}) async {
    try {
      emit(RegisterLoading());
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(RegisterSucceed()) ;
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
      emit(RegisterFailure('unknown exception'));
    }
  }
}
