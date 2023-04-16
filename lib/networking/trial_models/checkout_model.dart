import 'dart:convert';

class CheckoutModel {
  CheckoutModel({
    required this.number,
    required this.basket,
    required this.url,
    required this.lines,
    required this.owner,
    required this.billingAddress,
    required this.currency,
    required this.totalInclTax,
    required this.totalExclTax,
    required this.shippingInclTax,
    required this.shippingExclTax,
    required this.shippingAddress,
    required this.shippingMethod,
    required this.shippingCode,
    required this.status,
    required this.email,
    required this.datePlaced,
    required this.paymentUrl,
    required this.offerDiscounts,
    required this.voucherDiscounts,
    required this.surcharges,
  });

  final String number;
  final String basket;
  final String url;
  final String lines;
  final String owner;
  final IngAddress billingAddress;
  final String currency;
  final String totalInclTax;
  final String totalExclTax;
  final String shippingInclTax;
  final String shippingExclTax;
  final IngAddress shippingAddress;
  final String shippingMethod;
  final String shippingCode;
  final String status;
  final String email;
  final DateTime datePlaced;
  final String paymentUrl;
  final List<dynamic> offerDiscounts;
  final List<dynamic> voucherDiscounts;
  final List<dynamic> surcharges;

  factory CheckoutModel.fromRawJson(String str) =>
      CheckoutModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CheckoutModel.fromJson(Map<String, dynamic> json) => CheckoutModel(
        number: json["number"],
        basket: json["basket"],
        url: json["url"],
        lines: json["lines"],
        owner: json["owner"],
        billingAddress: IngAddress.fromJson(json["billing_address"]),
        currency: json["currency"],
        totalInclTax: json["total_incl_tax"],
        totalExclTax: json["total_excl_tax"],
        shippingInclTax: json["shipping_incl_tax"],
        shippingExclTax: json["shipping_excl_tax"],
        shippingAddress: IngAddress.fromJson(json["shipping_address"]),
        shippingMethod: json["shipping_method"],
        shippingCode: json["shipping_code"],
        status: json["status"],
        email: json["email"],
        datePlaced: DateTime.parse(json["date_placed"]),
        paymentUrl: json["payment_url"],
        offerDiscounts:
            List<dynamic>.from(json["offer_discounts"].map((x) => x)),
        voucherDiscounts:
            List<dynamic>.from(json["voucher_discounts"].map((x) => x)),
        surcharges: List<dynamic>.from(json["surcharges"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "basket": basket,
        "url": url,
        "lines": lines,
        "owner": owner,
        "billing_address": billingAddress.toJson(),
        "currency": currency,
        "total_incl_tax": totalInclTax,
        "total_excl_tax": totalExclTax,
        "shipping_incl_tax": shippingInclTax,
        "shipping_excl_tax": shippingExclTax,
        "shipping_address": shippingAddress.toJson(),
        "shipping_method": shippingMethod,
        "shipping_code": shippingCode,
        "status": status,
        "email": email,
        "date_placed": datePlaced.toIso8601String(),
        "payment_url": paymentUrl,
        "offer_discounts": List<dynamic>.from(offerDiscounts.map((x) => x)),
        "voucher_discounts": List<dynamic>.from(voucherDiscounts.map((x) => x)),
        "surcharges": List<dynamic>.from(surcharges.map((x) => x)),
      };
}

class IngAddress {
  IngAddress({
    required this.id,
    required this.country,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.state,
    required this.postcode,
    required this.searchText,
    this.phoneNumber,
    this.notes,
  });

  final int id;
  final String country;
  final String title;
  final String firstName;
  final String lastName;
  final String line1;
  final String line2;
  final String line3;
  final String line4;
  final String state;
  final String postcode;
  final String searchText;
  final String? phoneNumber;
  final String? notes;

  factory IngAddress.fromRawJson(String str) =>
      IngAddress.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory IngAddress.fromJson(Map<String, dynamic> json) => IngAddress(
        id: json["id"],
        country: json["country"],
        title: json["title"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        line1: json["line1"],
        line2: json["line2"],
        line3: json["line3"],
        line4: json["line4"],
        state: json["state"],
        postcode: json["postcode"],
        searchText: json["search_text"],
        phoneNumber: json["phone_number"],
        notes: json["notes"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country": country,
        "title": title,
        "first_name": firstName,
        "last_name": lastName,
        "line1": line1,
        "line2": line2,
        "line3": line3,
        "line4": line4,
        "state": state,
        "postcode": postcode,
        "search_text": searchText,
        "phone_number": phoneNumber,
        "notes": notes,
      };
}
