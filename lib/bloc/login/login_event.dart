import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {}

class OtpLoginEvent extends LoginEvent {
  final String phoneNumber;
  OtpLoginEvent({required this.phoneNumber});
  @override
  List<Object?> get props => [phoneNumber];
}
