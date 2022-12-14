part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  LoginLoaded(this.loginModel);
  LoginModel loginModel;
}

class LoginFailed extends LoginState {}

class LoginCheck extends LoginState {}

class LoginChecked extends LoginState {
  bool isNew;
  LoginChecked(this.isNew);
}
