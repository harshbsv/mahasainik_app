// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'best_selling_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BestSellingResponseModel _$BestSellingResponseModelFromJson(
        Map<String, dynamic> json) =>
    BestSellingResponseModel(
      count: json['count'] as int?,
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BestSellingResponseModelToJson(
        BestSellingResponseModel instance) =>
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
      image: json['image'] as String?,
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
      'image': instance.image,
      'categories': instance.categories,
    };

Availability _$AvailabilityFromJson(Map<String, dynamic> json) => Availability(
      is_available_to_buy: json['is_available_to_buy'] as bool?,
      num_available: json['num_available'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AvailabilityToJson(Availability instance) =>
    <String, dynamic>{
      'is_available_to_buy': instance.is_available_to_buy,
      'num_available': instance.num_available,
      'message': instance.message,
    };

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
      currency: json['currency'] as String?,
      excl_tax: json['excl_tax'] as String?,
      incl_tax: json['incl_tax'] as String?,
      tax: json['tax'] as String?,
    );

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'currency': instance.currency,
      'excl_tax': instance.excl_tax,
      'incl_tax': instance.incl_tax,
      'tax': instance.tax,
    };
