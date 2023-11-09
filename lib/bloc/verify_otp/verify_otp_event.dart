part of 'verify_otp_bloc.dart';

@immutable
abstract class VerifyOtpEvent {}

class VerifyOtpInitialEvent extends VerifyOtpEvent {}

class VerifyOtpLoadingEvent extends VerifyOtpEvent {
  final String mobile, otp;

  VerifyOtpLoadingEvent(this.mobile, this.otp);
}

class VerifyOtpSuccessEvent extends VerifyOtpEvent {}

class VerifyOtpErrorEvent extends VerifyOtpEvent {}
