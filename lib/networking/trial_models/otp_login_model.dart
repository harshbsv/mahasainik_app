// To parse this JSON data, do
//
//     final otpLoginModel = otpLoginModelFromJson(jsonString);

import 'dart:convert';

class OtpLoginModel {
  OtpLoginModel({
    required this.token,
  });

  String token;

  factory OtpLoginModel.fromRawJson(String str) =>
      OtpLoginModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OtpLoginModel.fromJson(Map<String, dynamic> json) => OtpLoginModel(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
