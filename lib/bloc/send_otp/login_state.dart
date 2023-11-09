part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final SendOtpResponseModel responseModel;

  LoginSuccessState(this.responseModel);
}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState(this.error);
}
