// To parse this JSON data, do
//
//     final getUserProfile = getUserProfileFromJson(jsonString);

import 'dart:convert';

class GetUserProfile {
  GetUserProfile({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNo,
    required this.address,
    required this.profilePhoto,
  });

  final String firstName;
  final String lastName;
  final String email;
  final int phoneNo;
  final List<Address> address;
  final String profilePhoto;

  factory GetUserProfile.fromRawJson(String str) =>
      GetUserProfile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetUserProfile.fromJson(Map<String, dynamic> json) => GetUserProfile(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phoneNo: json["phone_no"],
        address:
            List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
        profilePhoto: json["profile_photo"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone_no": phoneNo,
        "address": List<dynamic>.from(address.map((x) => x.toJson())),
        "profile_photo": profilePhoto,
      };
}

class Address {
  Address({
    required this.id,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.state,
    required this.postcode,
    required this.countryId,
    required this.searchText,
    required this.phoneNumber,
    required this.notes,
    required this.userId,
    required this.isDefaultForShipping,
    required this.isDefaultForBilling,
    required this.numOrdersAsShippingAddress,
    required this.numOrdersAsBillingAddress,
    required this.hash,
    required this.dateCreated,
    this.placeName,
  });

  final int id;
  final String title;
  final String firstName;
  final String lastName;
  final String line1;
  final String line2;
  final String line3;
  final String line4;
  final String state;
  final String postcode;
  final String countryId;
  final String searchText;
  final String phoneNumber;
  final String notes;
  final int userId;
  final bool isDefaultForShipping;
  final bool isDefaultForBilling;
  final int numOrdersAsShippingAddress;
  final int numOrdersAsBillingAddress;
  final String hash;
  final DateTime dateCreated;
  final String? placeName;

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        title: json["title"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        line1: json["line1"],
        line2: json["line2"],
        line3: json["line3"],
        line4: json["line4"],
        state: json["state"],
        postcode: json["postcode"],
        countryId: json["country_id"],
        searchText: json["search_text"],
        phoneNumber: json["phone_number"],
        notes: json["notes"],
        userId: json["user_id"],
        isDefaultForShipping: json["is_default_for_shipping"],
        isDefaultForBilling: json["is_default_for_billing"],
        numOrdersAsShippingAddress: json["num_orders_as_shipping_address"],
        numOrdersAsBillingAddress: json["num_orders_as_billing_address"],
        hash: json["hash"],
        dateCreated: DateTime.parse(json["date_created"]),
        placeName: json["place_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "first_name": firstName,
        "last_name": lastName,
        "line1": line1,
        "line2": line2,
        "line3": line3,
        "line4": line4,
        "state": state,
        "postcode": postcode,
        "country_id": countryId,
        "search_text": searchText,
        "phone_number": phoneNumber,
        "notes": notes,
        "user_id": userId,
        "is_default_for_shipping": isDefaultForShipping,
        "is_default_for_billing": isDefaultForBilling,
        "num_orders_as_shipping_address": numOrdersAsShippingAddress,
        "num_orders_as_billing_address": numOrdersAsBillingAddress,
        "hash": hash,
        "date_created": dateCreated.toIso8601String(),
        "place_name": placeName,
      };
}
