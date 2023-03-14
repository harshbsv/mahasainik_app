// To parse this JSON data, do
//
//     final bestSellingModel = bestSellingModelFromJson(jsonString);

import 'dart:convert';

class BestSellingModel {
  BestSellingModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory BestSellingModel.fromRawJson(String str) =>
      BestSellingModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BestSellingModel.fromJson(Map<String, dynamic> json) =>
      BestSellingModel(
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
  });

  String url;
  int id;
  String upc;
  String title;
  Price price;
  Availability availability;
  String image;

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
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "id": id,
        "upc": upc,
        "title": title,
        "price": price.toJson(),
        "availability": availability.toJson(),
        "image": image,
      };
}

class Availability {
  Availability({
    required this.isAvailableToBuy,
    required this.numAvailable,
    required this.message,
  });

  bool isAvailableToBuy;
  int numAvailable;
  String message;

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

  String currency;
  String exclTax;
  String inclTax;
  String tax;

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
