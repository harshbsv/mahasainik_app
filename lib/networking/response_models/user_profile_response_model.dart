import 'package:json_annotation/json_annotation.dart';

part 'user_profile_response_model.g.dart';

@JsonSerializable()
class UserProfileResponseModel {
  UserProfileResponseModel({
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.phone_no,
    required this.address,
    required this.profile_photo,
  });

  final String first_name;
  final String last_name;
  final String email;
  final int phone_no;
  final List<Address> address;
  final String profile_photo;

  factory UserProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileResponseModelToJson(this);
}

@JsonSerializable()
class Address {
  Address({
    required this.id,
    required this.title,
    required this.first_name,
    required this.last_name,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.state,
    required this.postcode,
    required this.country_id,
    required this.search_text,
    required this.phone_number,
    required this.notes,
    required this.user_id,
    required this.is_default_for_shipping,
    required this.is_default_for_billing,
    required this.num_orders_as_shipping_address,
    required this.num_orders_as_billing_address,
    required this.hash,
    required this.date_created,
    this.place_name,
  });

  final int id;
  final String title;
  final String first_name;
  final String last_name;
  final String line1;
  final String line2;
  final String line3;
  final String line4;
  final String state;
  final String postcode;
  final String country_id;
  final String search_text;
  final String phone_number;
  final String notes;
  final int user_id;
  final bool is_default_for_shipping;
  final bool is_default_for_billing;
  final int num_orders_as_shipping_address;
  final int num_orders_as_billing_address;
  final String hash;
  final DateTime date_created;
  final String? place_name;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
