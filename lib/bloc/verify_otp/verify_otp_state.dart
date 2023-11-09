part of 'verify_otp_bloc.dart';

@immutable
abstract class VerifyOtpState {}

class VerifyOtpInitialState extends VerifyOtpState {}

class VerifyOtpLoadingState extends VerifyOtpState {}

class VerifyOtpSuccessState extends VerifyOtpState {
  final VerifyOtpResponseModel responseModel;

  VerifyOtpSuccessState(this.responseModel);
}

class VerifyOtpErrorState extends VerifyOtpState {
  final String error;

  VerifyOtpErrorState(this.error);
}
