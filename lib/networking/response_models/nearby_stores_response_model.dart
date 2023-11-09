import 'package:json_annotation/json_annotation.dart';

part 'nearby_stores_response_model.g.dart';

@JsonSerializable()
class NearbyStoresResponseModel {
  final String store_id;
  final String store_name;
  final String line1;
  final String line2;
  final String line3;
  final String line4;
  final String state;
  final String postcode;
  final String latitude;
  final String longitude;
  final String country;

  NearbyStoresResponseModel({
    required this.store_id,
    required this.store_name,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.state,
    required this.postcode,
    required this.latitude,
    required this.longitude,
    required this.country,
  });

  factory NearbyStoresResponseModel.fromJson(Map<String, dynamic> json) =>
      _$NearbyStoresResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$NearbyStoresResponseModelToJson(this);
}
