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

  String firstName;
  String lastName;
  String email;
  int phoneNo;
  List<Address> address;
  String profilePhoto;

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
    required this.placeName,
  });

  int id;
  String title;
  String firstName;
  String lastName;
  String line1;
  String line2;
  String line3;
  String line4;
  String state;
  String postcode;
  String countryId;
  String searchText;
  String phoneNumber;
  String notes;
  int userId;
  bool isDefaultForShipping;
  bool isDefaultForBilling;
  int numOrdersAsShippingAddress;
  int numOrdersAsBillingAddress;
  String hash;
  DateTime dateCreated;
  String placeName;

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
