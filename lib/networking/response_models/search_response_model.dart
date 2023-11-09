import 'package:json_annotation/json_annotation.dart';

part 'search_response_model.g.dart';

@JsonSerializable()
class SearchResponseModel {
  final int count;
  final String next;
  final dynamic previous;
  final List<Result> results;

  SearchResponseModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory SearchResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResponseModelToJson(this);
}

@JsonSerializable()
class Result {
  final String url;
  final int id;
  final String upc;
  final String title;
  final Price price;
  final Availability availability;
  final String image;
  final List<String> categories;

  Result({
    required this.url,
    required this.id,
    required this.upc,
    required this.title,
    required this.price,
    required this.availability,
    required this.image,
    required this.categories,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class Availability {
  final bool is_available_to_buy;
  final int num_available;
  final String message;

  Availability({
    required this.is_available_to_buy,
    required this.num_available,
    required this.message,
  });

  factory Availability.fromJson(Map<String, dynamic> json) =>
      _$AvailabilityFromJson(json);

  Map<String, dynamic> toJson() => _$AvailabilityToJson(this);
}

@JsonSerializable()
class Price {
  final String currency;
  final String excl_tax;
  final String incl_tax;
  final String tax;

  Price({
    required this.currency,
    required this.excl_tax,
    required this.incl_tax,
    required this.tax,
  });

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);

  Map<String, dynamic> toJson() => _$PriceToJson(this);
}
