// To parse this JSON data, do
//
//     final getAddressModel = getAddressModelFromJson(jsonString);

import 'dart:convert';

class GetAddressModel {
  GetAddressModel({
    required this.id,
    this.placeName,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.state,
    required this.postcode,
    required this.searchText,
    required this.phoneNumber,
    required this.notes,
    required this.isDefaultForShipping,
    required this.isDefaultForBilling,
    required this.country,
    required this.url,
  });

  final int id;
  final String? placeName;
  final String title;
  final String firstName;
  final String lastName;
  final String line1;
  final String line2;
  final String line3;
  final String line4;
  final String state;
  final String postcode;
  final String searchText;
  final String phoneNumber;
  final String notes;
  final bool isDefaultForShipping;
  final bool isDefaultForBilling;
  final String country;
  final String url;

  factory GetAddressModel.fromRawJson(String str) =>
      GetAddressModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAddressModel.fromJson(Map<String, dynamic> json) =>
      GetAddressModel(
        id: json["id"],
        placeName: json["place_name"],
        title: json["title"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        line1: json["line1"],
        line2: json["line2"],
        line3: json["line3"],
        line4: json["line4"],
        state: json["state"],
        postcode: json["postcode"],
        searchText: json["search_text"],
        phoneNumber: json["phone_number"],
        notes: json["notes"],
        isDefaultForShipping: json["is_default_for_shipping"],
        isDefaultForBilling: json["is_default_for_billing"],
        country: json["country"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "place_name": placeName,
        "title": title,
        "first_name": firstName,
        "last_name": lastName,
        "line1": line1,
        "line2": line2,
        "line3": line3,
        "line4": line4,
        "state": state,
        "postcode": postcode,
        "search_text": searchText,
        "phone_number": phoneNumber,
        "notes": notes,
        "is_default_for_shipping": isDefaultForShipping,
        "is_default_for_billing": isDefaultForBilling,
        "country": country,
        "url": url,
      };
}
