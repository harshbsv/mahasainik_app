// To parse this JSON data, do
//
//     final productsListModel = productsListModelFromJson(jsonString);
import 'dart:convert';

class ProductsListModel {
  ProductsListModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory ProductsListModel.fromRawJson(String str) =>
      ProductsListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductsListModel.fromJson(Map<String, dynamic> json) =>
      ProductsListModel(
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
    required this.images,
  });

  String url;
  int id;
  String upc;
  String title;
  Price price;
  Availability availability;
  List<Images> images;

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        url: json["url"],
        id: json["id"],
        upc: json["upc"],
        title: json["title"],
        price: Price.fromJson(json["price"]),
        availability: Availability.fromJson(json["availability"]),
        images:
            List<Images>.from(json["images"].map((x) => Images.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "id": id,
        "upc": upc,
        "title": title,
        "price": price.toJson(),
        "availability": availability.toJson(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
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

class Images {
  Images({
    required this.id,
    required this.original,
    required this.caption,
    required this.displayOrder,
    required this.dateCreated,
  });

  int id;
  String original;
  String caption;
  int displayOrder;
  DateTime dateCreated;

  factory Images.fromRawJson(String str) => Images.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        id: json["id"],
        original: json["original"],
        caption: json["caption"],
        displayOrder: json["display_order"],
        dateCreated: DateTime.parse(json["date_created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "original": original,
        "caption": caption,
        "display_order": displayOrder,
        "date_created": dateCreated.toIso8601String(),
      };
}

class Price {
  Price({
    required this.currency,
    required this.exclTax,
    required this.inclTax,
    required this.tax,
  });

  Currency currency;
  String exclTax;
  String inclTax;
  String tax;

  factory Price.fromRawJson(String str) => Price.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        currency: currencyValues.map[json["currency"]]!,
        exclTax: json["excl_tax"],
        inclTax: json["incl_tax"],
        tax: json["tax"],
      );

  Map<String, dynamic> toJson() => {
        "currency": currencyValues.reverse[currency],
        "excl_tax": exclTax,
        "incl_tax": inclTax,
        "tax": tax,
      };
}

enum Currency { INR }

final currencyValues = EnumValues({"INR": Currency.INR});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
