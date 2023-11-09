part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginInitialEvent extends LoginEvent {}

class LoginLoadingEvent extends LoginEvent {
  final String mobile;

  LoginLoadingEvent(this.mobile);
}

class LoginSuccessEvent extends LoginEvent {}

class LoginErrorEvent extends LoginEvent {}
