import 'package:json_annotation/json_annotation.dart';

part 'products_response_model.g.dart';

@JsonSerializable()
class ProductsResponseModel {
  final int? count;
  final dynamic next;
  final dynamic previous;
  final List<Result>? results;

  ProductsResponseModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory ProductsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProductsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsResponseModelToJson(this);
}

@JsonSerializable()
class Result {
  final String? url;
  final int? id;
  final String? upc;
  final String? title;
  final Price? price;
  final Availability? availability;
  final List<Image>? images;
  final List<String>? categories;

  Result({
    this.url,
    this.id,
    this.upc,
    this.title,
    this.price,
    this.availability,
    this.images,
    this.categories,
  });
  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class Availability {
  final bool? isAvailableToBuy;
  final int? numAvailable;
  final String? message;

  Availability({
    this.isAvailableToBuy,
    this.numAvailable,
    this.message,
  });
  factory Availability.fromJson(Map<String, dynamic> json) =>
      _$AvailabilityFromJson(json);

  Map<String, dynamic> toJson() => _$AvailabilityToJson(this);
}

@JsonSerializable()
class Image {
  final int? id;
  final String? original;
  final String? caption;
  final int? displayOrder;
  final DateTime? dateCreated;

  Image({
    this.id,
    this.original,
    this.caption,
    this.displayOrder,
    this.dateCreated,
  });
  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToJson(this);
}

@JsonSerializable()
class Price {
  final String? currency;
  final String? exclTax;
  final String? inclTax;
  final String? tax;

  Price({
    this.currency,
    this.exclTax,
    this.inclTax,
    this.tax,
  });
  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);

  Map<String, dynamic> toJson() => _$PriceToJson(this);
}
