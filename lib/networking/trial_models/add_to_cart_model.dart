import 'dart:convert';

class AddToCartModel {
  AddToCartModel({
    required this.id,
    required this.ownerId,
    required this.status,
    required this.lines,
    required this.url,
    required this.totalExclTax,
    required this.totalExclTaxExclDiscounts,
    required this.totalInclTax,
    required this.totalInclTaxExclDiscounts,
    required this.totalTax,
    required this.currency,
    required this.voucherDiscounts,
    required this.offerDiscounts,
    required this.isTaxKnown,
  });

  final int id;
  final int ownerId;
  final String status;
  final List<Line> lines;
  final String url;
  final String totalExclTax;
  final String totalExclTaxExclDiscounts;
  final String totalInclTax;
  final String totalInclTaxExclDiscounts;
  final String totalTax;
  final String currency;
  final List<dynamic> voucherDiscounts;
  final List<dynamic> offerDiscounts;
  final bool isTaxKnown;

  factory AddToCartModel.fromRawJson(String str) =>
      AddToCartModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddToCartModel.fromJson(Map<String, dynamic> json) => AddToCartModel(
        id: json["id"],
        ownerId: json["owner_id"],
        status: json["status"],
        lines: List<Line>.from(json["lines"].map((x) => Line.fromJson(x))),
        url: json["url"],
        totalExclTax: json["total_excl_tax"],
        totalExclTaxExclDiscounts: json["total_excl_tax_excl_discounts"],
        totalInclTax: json["total_incl_tax"],
        totalInclTaxExclDiscounts: json["total_incl_tax_excl_discounts"],
        totalTax: json["total_tax"],
        currency: json["currency"],
        voucherDiscounts:
            List<dynamic>.from(json["voucher_discounts"].map((x) => x)),
        offerDiscounts:
            List<dynamic>.from(json["offer_discounts"].map((x) => x)),
        isTaxKnown: json["is_tax_known"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "owner_id": ownerId,
        "status": status,
        "lines": List<dynamic>.from(lines.map((x) => x.toJson())),
        "url": url,
        "total_excl_tax": totalExclTax,
        "total_excl_tax_excl_discounts": totalExclTaxExclDiscounts,
        "total_incl_tax": totalInclTax,
        "total_incl_tax_excl_discounts": totalInclTaxExclDiscounts,
        "total_tax": totalTax,
        "currency": currency,
        "voucher_discounts": List<dynamic>.from(voucherDiscounts.map((x) => x)),
        "offer_discounts": List<dynamic>.from(offerDiscounts.map((x) => x)),
        "is_tax_known": isTaxKnown,
      };
}

class Line {
  Line({
    required this.url,
    required this.product,
    required this.productId,
    required this.quantity,
    required this.attributes,
    required this.priceCurrency,
    required this.priceExclTax,
    required this.priceInclTax,
    required this.priceInclTaxExclDiscounts,
    required this.priceExclTaxExclDiscounts,
    required this.isTaxKnown,
    this.warning,
    required this.basket,
    required this.stockrecord,
    required this.dateCreated,
    required this.dateUpdated,
  });

  final String url;
  final String product;
  final int productId;
  final int quantity;
  final List<dynamic> attributes;
  final String priceCurrency;
  final String priceExclTax;
  final String priceInclTax;
  final String priceInclTaxExclDiscounts;
  final String priceExclTaxExclDiscounts;
  final bool isTaxKnown;
  final dynamic warning;
  final String basket;
  final String stockrecord;
  final DateTime dateCreated;
  final DateTime dateUpdated;

  factory Line.fromRawJson(String str) => Line.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Line.fromJson(Map<String, dynamic> json) => Line(
        url: json["url"],
        product: json["product"],
        productId: json["product_id"],
        quantity: json["quantity"],
        attributes: List<dynamic>.from(json["attributes"].map((x) => x)),
        priceCurrency: json["price_currency"],
        priceExclTax: json["price_excl_tax"],
        priceInclTax: json["price_incl_tax"],
        priceInclTaxExclDiscounts: json["price_incl_tax_excl_discounts"],
        priceExclTaxExclDiscounts: json["price_excl_tax_excl_discounts"],
        isTaxKnown: json["is_tax_known"],
        warning: json["warning"],
        basket: json["basket"],
        stockrecord: json["stockrecord"],
        dateCreated: DateTime.parse(json["date_created"]),
        dateUpdated: DateTime.parse(json["date_updated"]),
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "product": product,
        "product_id": productId,
        "quantity": quantity,
        "attributes": List<dynamic>.from(attributes.map((x) => x)),
        "price_currency": priceCurrency,
        "price_excl_tax": priceExclTax,
        "price_incl_tax": priceInclTax,
        "price_incl_tax_excl_discounts": priceInclTaxExclDiscounts,
        "price_excl_tax_excl_discounts": priceExclTaxExclDiscounts,
        "is_tax_known": isTaxKnown,
        "warning": warning,
        "basket": basket,
        "stockrecord": stockrecord,
        "date_created": dateCreated.toIso8601String(),
        "date_updated": dateUpdated.toIso8601String(),
      };
}
