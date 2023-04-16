import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mahasainik_app/UI/products/product_detail_screen.dart';
import 'package:mahasainik_app/networking/trial_models/sub_categories_model.dart';
import 'package:mahasainik_app/utils/color_assets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubCategoriesScreen extends StatefulWidget {
  const SubCategoriesScreen({
    Key? key,
    required this.categoryTitle,
  }) : super(key: key);

  final String categoryTitle;

  @override
  State<SubCategoriesScreen> createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  late String? token;
  Future<SubCategoriesModel>? _subCategory;

  Future<SubCategoriesModel> getSubCategoryData(String category) async {
    final String subCategoryUrl =
        'https://mahasainikstore.com/api/categories/$category/products/?store_id=1&limit=20&offset=0';
    try {
      final tokenPref = await SharedPreferences.getInstance();
      token = tokenPref.getString('token');
      print('tokenpref: $token');
      final response = await http.get(
        Uri.parse(subCategoryUrl),
      );
      if (response.statusCode == 200) {
        print(response.body);
        final subCategory = SubCategoriesModel.fromJson(
          jsonDecode(
            response.body.toString(),
          ),
        );
        return subCategory;
      } else {
        throw 'Error fetching categories';
      }
    } catch (e) {
      throw 'Error loading categories.';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _subCategory = getSubCategoryData(widget.categoryTitle.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryTitle),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<SubCategoriesModel>(
              future: _subCategory,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.count == 0) {
                    return const Center(
                      child: Text(
                        'No items found.',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.blackColor,
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.count,
                      itemBuilder: (context, index) {
                        // return Text(
                        //   snapshot.data!.results[index].title,
                        //   style: const TextStyle(
                        //     fontSize: 18,
                        //     color: AppColors.blackColor,
                        //   ),
                        // );
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen(
                                  result: snapshot.data!.results[index],
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            leading: Image.network(
                              snapshot.data!.results[index].image,
                              height: 80,
                            ),
                            title: Text(
                              snapshot.data!.results[index].title,
                              style: const TextStyle(
                                fontSize: 18,
                                color: AppColors.blackColor,
                              ),
                            ),
                            subtitle: Text(
                              snapshot.data!.results[index].price.inclTax,
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.blackColor,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
