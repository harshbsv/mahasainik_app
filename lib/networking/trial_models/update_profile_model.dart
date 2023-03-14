// To parse this JSON data, do
//
//     final updateUserProfile = updateUserProfileFromJson(jsonString);

import 'dart:convert';

class UpdateUserProfile {
  UpdateUserProfile({
    required this.message,
  });

  String message;

  factory UpdateUserProfile.fromRawJson(String str) =>
      UpdateUserProfile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateUserProfile.fromJson(Map<String, dynamic> json) =>
      UpdateUserProfile(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
