part of 'register_cubit.dart';

@immutable
class RegisterState {}

class RegisterInitial extends RegisterState {}
class RegisterSucceed extends RegisterState {}
class RegisterLoading extends RegisterState {}
class RegisterFailure extends RegisterState {
  final String errorMessage ;
  RegisterFailure(this.errorMessage) ;
}
