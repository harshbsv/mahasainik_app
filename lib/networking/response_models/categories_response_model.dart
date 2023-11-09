import 'package:json_annotation/json_annotation.dart';

part 'categories_response_model.g.dart';
@JsonSerializable()
class CategoriesResponseModel {
    final String? url;
    final String? breadcrumbs;
    final String? children;
    final String? name;
    final String? description;
    final dynamic meta_title;
    final String? meta_description;
    final String? image;
    final String? slug;
    final bool? is_public;
    final bool? ancestors_are_public;

    CategoriesResponseModel({
        this.url,
        this.breadcrumbs,
        this.children,
        this.name,
        this.description,
        this.meta_title,
        this.meta_description,
        this.image,
        this.slug,
        this.is_public,
        this.ancestors_are_public,
    });

    factory CategoriesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesResponseModelToJson(this);

}
