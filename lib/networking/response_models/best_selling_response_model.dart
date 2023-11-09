import 'package:json_annotation/json_annotation.dart';

part 'best_selling_response_model.g.dart';

@JsonSerializable()
class BestSellingResponseModel {
  final int? count;
  final dynamic next;
  final dynamic previous;
  final List<Result>? results;

  BestSellingResponseModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });
  factory BestSellingResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BestSellingResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BestSellingResponseModelToJson(this);
}

@JsonSerializable()
class Result {
  final String? url;
  final int? id;
  final String? upc;
  final String? title;
  final Price? price;
  final Availability? availability;
  final String? image;
  final List<String>? categories;

  Result({
    this.url,
    this.id,
    this.upc,
    this.title,
    this.price,
    this.availability,
    this.image,
    this.categories,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class Availability {
  final bool? is_available_to_buy;
  final int? num_available;
  final String? message;

  Availability({
    this.is_available_to_buy,
    this.num_available,
    this.message,
  });

  factory Availability.fromJson(Map<String, dynamic> json) =>
      _$AvailabilityFromJson(json);

  Map<String, dynamic> toJson() => _$AvailabilityToJson(this);
}

@JsonSerializable()
class Price {
  final String? currency;
  final String? excl_tax;
  final String? incl_tax;
  final String? tax;

  Price({
    this.currency,
    this.excl_tax,
    this.incl_tax,
    this.tax,
  });

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);

  Map<String, dynamic> toJson() => _$PriceToJson(this);
}
