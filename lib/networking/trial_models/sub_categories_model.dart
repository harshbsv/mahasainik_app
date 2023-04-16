// To parse this JSON data, do
//
//     final subCategoriesModel = subCategoriesModelFromJson(jsonString);

import 'dart:convert';

class SubCategoriesModel {
  SubCategoriesModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  final int count;
  final dynamic next;
  final dynamic previous;
  final List<Result> results;

  factory SubCategoriesModel.fromRawJson(String str) =>
      SubCategoriesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubCategoriesModel.fromJson(Map<String, dynamic> json) =>
      SubCategoriesModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
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

  final String url;
  final int id;
  final String upc;
  final String title;
  final Price price;
  final Availability availability;
  final String image;
  final List<String> categories;

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        url: json["url"],
        id: json["id"],
        upc: json["upc"],
        title: json["title"],
        price: Price.fromJson(json["price"]),
        availability: Availability.fromJson(json["availability"]),
        image: json["image"],
        categories: List<String>.from(json["categories"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "id": id,
        "upc": upc,
        "title": title,
        "price": price.toJson(),
        "availability": availability.toJson(),
        "image": image,
        "categories": List<dynamic>.from(categories.map((x) => x)),
      };
}

class Availability {
  Availability({
    required this.isAvailableToBuy,
    required this.numAvailable,
    required this.message,
  });

  final bool isAvailableToBuy;
  final int numAvailable;
  final String message;

  factory Availability.fromRawJson(String str) =>
      Availability.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Availability.fromJson(Map<String, dynamic> json) => Availability(
        isAvailableToBuy: json["is_available_to_buy"],
        numAvailable: json["num_available"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "is_available_to_buy": isAvailableToBuy,
        "num_available": numAvailable,
        "message": message,
      };
}

class Price {
  Price({
    required this.currency,
    required this.exclTax,
    required this.inclTax,
    required this.tax,
  });

  final String currency;
  final String exclTax;
  final String inclTax;
  final String tax;

  factory Price.fromRawJson(String str) => Price.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        currency: json["currency"],
        exclTax: json["excl_tax"],
        inclTax: json["incl_tax"],
        tax: json["tax"],
      );

  Map<String, dynamic> toJson() => {
        "currency": currency,
        "excl_tax": exclTax,
        "incl_tax": inclTax,
        "tax": tax,
      };
}
