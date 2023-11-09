// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nearby_store_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NearbyStoresRequestModel _$NearbyStoresRequestModelFromJson(
        Map<String, dynamic> json) =>
    NearbyStoresRequestModel(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$NearbyStoresRequestModelToJson(
        NearbyStoresRequestModel instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
