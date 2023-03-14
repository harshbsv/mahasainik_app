// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

class Categories {
  Categories({
    required this.url,
    required this.breadcrumbs,
    required this.children,
    required this.name,
    required this.description,
    required this.metaTitle,
    required this.metaDescription,
    required this.image,
    required this.slug,
    required this.isPublic,
    required this.ancestorsArePublic,
  });

  String url;
  String breadcrumbs;
  String children;
  String name;
  String description;
  dynamic metaTitle;
  String metaDescription;
  String image;
  String slug;
  bool isPublic;
  bool ancestorsArePublic;

  factory Categories.fromRawJson(String str) =>
      Categories.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        url: json["url"],
        breadcrumbs: json["breadcrumbs"],
        children: json["children"],
        name: json["name"],
        description: json["description"],
        metaTitle: json["meta_title"],
        metaDescription: json["meta_description"],
        image: json["image"],
        slug: json["slug"],
        isPublic: json["is_public"],
        ancestorsArePublic: json["ancestors_are_public"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "breadcrumbs": breadcrumbs,
        "children": children,
        "name": name,
        "description": description,
        "meta_title": metaTitle,
        "meta_description": metaDescription,
        "image": image,
        "slug": slug,
        "is_public": isPublic,
        "ancestors_are_public": ancestorsArePublic,
      };
}
