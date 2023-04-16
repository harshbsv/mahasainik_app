import 'dart:convert';

class AddAddressModel {
  AddAddressModel({
    required this.message,
  });

  final String message;

  factory AddAddressModel.fromRawJson(String str) =>
      AddAddressModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddAddressModel.fromJson(Map<String, dynamic> json) =>
      AddAddressModel(
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
      };
}
