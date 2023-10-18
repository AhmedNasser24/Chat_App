part of 'login_cubit.dart';

@immutable
class LoginState {}

class LoginInitial extends LoginState {}
class LoginSucceed extends LoginState {}
class LoginLoading extends LoginState {}
class LoginFailure extends LoginState {
  final String errorMessage ;
  LoginFailure({required this.errorMessage}) ;
}
