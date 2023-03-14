import 'package:json_annotation/json_annotation.dart';

part 'send_otp_response_model.g.dart';

@JsonSerializable()
class SendOTPResponseModel extends Object {
  @JsonKey(name: 'detail')
  String? details;

  @JsonKey(name: 'otp')
  String? otp;

  SendOTPResponseModel(
    this.details,
    this.otp,
  );

  factory SendOTPResponseModel.fromJson(Map<String, dynamic> srcJson) =>
      _$SendOTPResponseModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SendOTPResponseModelToJson(this);
}
