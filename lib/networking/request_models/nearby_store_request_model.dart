import 'package:json_annotation/json_annotation.dart';

part 'nearby_store_request_model.g.dart';

@JsonSerializable()
class NearbyStoresRequestModel {
  final double latitude;
  final double longitude;

  NearbyStoresRequestModel({
    required this.latitude,
    required this.longitude,
  });

  factory NearbyStoresRequestModel.fromJson(Map<String, dynamic> json) =>
      _$NearbyStoresRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$NearbyStoresRequestModelToJson(this);
}
