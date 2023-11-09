import 'package:json_annotation/json_annotation.dart';

part 'send_otp_response_model.g.dart';

@JsonSerializable()
class SendOtpResponseModel {
  final String? detail;
  final String? otp;

  SendOtpResponseModel({
    this.detail,
    this.otp,
  });

  factory SendOtpResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SendOtpResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SendOtpResponseModelToJson(this);
}
