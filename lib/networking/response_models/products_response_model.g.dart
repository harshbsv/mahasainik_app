// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsResponseModel _$ProductsResponseModelFromJson(
        Map<String, dynamic> json) =>
    ProductsResponseModel(
      count: json['count'] as int?,
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductsResponseModelToJson(
        ProductsResponseModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      url: json['url'] as String?,
      id: json['id'] as int?,
      upc: json['upc'] as String?,
      title: json['title'] as String?,
      price: json['price'] == null
          ? null
          : Price.fromJson(json['price'] as Map<String, dynamic>),
      availability: json['availability'] == null
          ? null
          : Availability.fromJson(json['availability'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'url': instance.url,
      'id': instance.id,
      'upc': instance.upc,
      'title': instance.title,
      'price': instance.price,
      'availability': instance.availability,
      'images': instance.images,
      'categories': instance.categories,
    };

Availability _$AvailabilityFromJson(Map<String, dynamic> json) => Availability(
      isAvailableToBuy: json['isAvailableToBuy'] as bool?,
      numAvailable: json['numAvailable'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AvailabilityToJson(Availability instance) =>
    <String, dynamic>{
      'isAvailableToBuy': instance.isAvailableToBuy,
      'numAvailable': instance.numAvailable,
      'message': instance.message,
    };

Image _$ImageFromJson(Map<String, dynamic> json) => Image(
      id: json['id'] as int?,
      original: json['original'] as String?,
      caption: json['caption'] as String?,
      displayOrder: json['displayOrder'] as int?,
      dateCreated: json['dateCreated'] == null
          ? null
          : DateTime.parse(json['dateCreated'] as String),
    );

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
      'id': instance.id,
      'original': instance.original,
      'caption': instance.caption,
      'displayOrder': instance.displayOrder,
      'dateCreated': instance.dateCreated?.toIso8601String(),
    };

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
      currency: json['currency'] as String?,
      exclTax: json['exclTax'] as String?,
      inclTax: json['inclTax'] as String?,
      tax: json['tax'] as String?,
    );

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'currency': instance.currency,
      'exclTax': instance.exclTax,
      'inclTax': instance.inclTax,
      'tax': instance.tax,
    };
