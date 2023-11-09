// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesResponseModel _$CategoriesResponseModelFromJson(
        Map<String, dynamic> json) =>
    CategoriesResponseModel(
      url: json['url'] as String?,
      breadcrumbs: json['breadcrumbs'] as String?,
      children: json['children'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      meta_title: json['meta_title'],
      meta_description: json['meta_description'] as String?,
      image: json['image'] as String?,
      slug: json['slug'] as String?,
      is_public: json['is_public'] as bool?,
      ancestors_are_public: json['ancestors_are_public'] as bool?,
    );

Map<String, dynamic> _$CategoriesResponseModelToJson(
        CategoriesResponseModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'breadcrumbs': instance.breadcrumbs,
      'children': instance.children,
      'name': instance.name,
      'description': instance.description,
      'meta_title': instance.meta_title,
      'meta_description': instance.meta_description,
      'image': instance.image,
      'slug': instance.slug,
      'is_public': instance.is_public,
      'ancestors_are_public': instance.ancestors_are_public,
    };
