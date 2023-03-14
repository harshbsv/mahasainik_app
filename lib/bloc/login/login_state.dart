import 'package:mahasainik_app/bloc/bloc_common_state.dart';
import 'package:mahasainik_app/error/app_error.dart';

abstract class LoginState extends ApiState {
  LoginState.completed(data) : super.completed(data);
  LoginState.loading(String message) : super.loading(message);
  LoginState.error(AppError error) : super.error(error);
}

class OtpLoginState extends LoginState {
  late bool isValidNumber;
  String? mobileNumber;
  String? errorMessage;
  OtpLoginState.completed(
      {required this.isValidNumber, this.mobileNumber, this.errorMessage})
      : super.completed(isValidNumber);
  OtpLoginState.loading(String message) : super.loading(message);
  OtpLoginState.error(AppError error) : super.error(error);
}
