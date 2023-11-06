part of 'auth_bloc.dart';


class AuthState {}

class AuthInitial extends AuthState {}
class LoginSucceed extends AuthState {}
class LoginLoading extends AuthState {}
class LoginFailure extends AuthState {
  final String errorMessage ;
  LoginFailure({required this.errorMessage}) ;
}
class RegisterSucceed extends AuthState {}
class RegisterLoading extends AuthState {}
class RegisterFailure extends AuthState {
  final String errorMessage ;
  RegisterFailure(this.errorMessage) ;
}
