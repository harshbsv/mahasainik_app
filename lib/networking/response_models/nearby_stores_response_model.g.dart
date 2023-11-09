// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nearby_stores_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NearbyStoresResponseModel _$NearbyStoresResponseModelFromJson(
        Map<String, dynamic> json) =>
    NearbyStoresResponseModel(
      store_id: json['store_id'] as String,
      store_name: json['store_name'] as String,
      line1: json['line1'] as String,
      line2: json['line2'] as String,
      line3: json['line3'] as String,
      line4: json['line4'] as String,
      state: json['state'] as String,
      postcode: json['postcode'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
      country: json['country'] as String,
    );

Map<String, dynamic> _$NearbyStoresResponseModelToJson(
        NearbyStoresResponseModel instance) =>
    <String, dynamic>{
      'store_id': instance.store_id,
      'store_name': instance.store_name,
      'line1': instance.line1,
      'line2': instance.line2,
      'line3': instance.line3,
      'line4': instance.line4,
      'state': instance.state,
      'postcode': instance.postcode,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'country': instance.country,
    };
