// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileResponseModel _$UserProfileResponseModelFromJson(
        Map<String, dynamic> json) =>
    UserProfileResponseModel(
      first_name: json['first_name'] as String,
      last_name: json['last_name'] as String,
      email: json['email'] as String,
      phone_no: json['phone_no'] as int,
      address: (json['address'] as List<dynamic>)
          .map((e) => Address.fromJson(e as Map<String, dynamic>))
          .toList(),
      profile_photo: json['profile_photo'] as String,
    );

Map<String, dynamic> _$UserProfileResponseModelToJson(
        UserProfileResponseModel instance) =>
    <String, dynamic>{
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'phone_no': instance.phone_no,
      'address': instance.address,
      'profile_photo': instance.profile_photo,
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      id: json['id'] as int,
      title: json['title'] as String,
      first_name: json['first_name'] as String,
      last_name: json['last_name'] as String,
      line1: json['line1'] as String,
      line2: json['line2'] as String,
      line3: json['line3'] as String,
      line4: json['line4'] as String,
      state: json['state'] as String,
      postcode: json['postcode'] as String,
      country_id: json['country_id'] as String,
      search_text: json['search_text'] as String,
      phone_number: json['phone_number'] as String,
      notes: json['notes'] as String,
      user_id: json['user_id'] as int,
      is_default_for_shipping: json['is_default_for_shipping'] as bool,
      is_default_for_billing: json['is_default_for_billing'] as bool,
      num_orders_as_shipping_address:
          json['num_orders_as_shipping_address'] as int,
      num_orders_as_billing_address:
          json['num_orders_as_billing_address'] as int,
      hash: json['hash'] as String,
      date_created: DateTime.parse(json['date_created'] as String),
      place_name: json['place_name'] as String?,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'line1': instance.line1,
      'line2': instance.line2,
      'line3': instance.line3,
      'line4': instance.line4,
      'state': instance.state,
      'postcode': instance.postcode,
      'country_id': instance.country_id,
      'search_text': instance.search_text,
      'phone_number': instance.phone_number,
      'notes': instance.notes,
      'user_id': instance.user_id,
      'is_default_for_shipping': instance.is_default_for_shipping,
      'is_default_for_billing': instance.is_default_for_billing,
      'num_orders_as_shipping_address': instance.num_orders_as_shipping_address,
      'num_orders_as_billing_address': instance.num_orders_as_billing_address,
      'hash': instance.hash,
      'date_created': instance.date_created.toIso8601String(),
      'place_name': instance.place_name,
    };
