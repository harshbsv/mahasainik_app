import 'package:json_annotation/json_annotation.dart';

part 'send_otp_request_model.g.dart';

@JsonSerializable()
class SendOTPRequestModel extends Object {
  @JsonKey(name: 'mobile')
  String? mobile;

  SendOTPRequestModel(
    this.mobile,
  );

  factory SendOTPRequestModel.fromJson(Map<String, dynamic> srcJson) =>
      _$SendOTPRequestModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SendOTPRequestModelToJson(this);
}
