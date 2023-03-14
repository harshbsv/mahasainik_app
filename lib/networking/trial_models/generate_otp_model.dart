// To parse this JSON data, do
//
//     final generateOtpModel = generateOtpModelFromJson(jsonString);

import 'dart:convert';

class GenerateOtpModel {
  GenerateOtpModel({
    required this.detail,
    required this.otp,
  });

  String detail;
  String otp;

  factory GenerateOtpModel.fromRawJson(String str) =>
      GenerateOtpModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GenerateOtpModel.fromJson(Map<String, dynamic> json) =>
      GenerateOtpModel(
        detail: json["detail"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "detail": detail,
        "otp": otp,
      };
}
