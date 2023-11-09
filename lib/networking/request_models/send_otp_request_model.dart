import 'package:json_annotation/json_annotation.dart';

part 'send_otp_request_model.g.dart';

@JsonSerializable()
class SendOtpRequestModel extends Object {
  @JsonKey(name: 'mobile')
  final String? mobile;

  SendOtpRequestModel({
    this.mobile,
  });

  factory SendOtpRequestModel.fromJson(Map<String, dynamic> srcJson) =>
      _$SendOtpRequestModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SendOtpRequestModelToJson(this);
}
