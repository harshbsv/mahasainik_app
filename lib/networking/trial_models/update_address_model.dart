import 'dart:convert';

class UpdateAddressModel {
  UpdateAddressModel({
    required this.message,
  });

  final String message;

  factory UpdateAddressModel.fromRawJson(String str) =>
      UpdateAddressModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateAddressModel.fromJson(Map<String, dynamic> json) =>
      UpdateAddressModel(
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
      };
}
