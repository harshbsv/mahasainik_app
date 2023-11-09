import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_request_model.g.dart';

@JsonSerializable()
class VerifyOtpRequestModel {
  @JsonKey(name: 'mobile')
  final String? mobile;
  @JsonKey(name: 'token')
  final String? token;

  VerifyOtpRequestModel({
    this.mobile,
    this.token,
  });

  factory VerifyOtpRequestModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOtpRequestModelToJson(this);
}
