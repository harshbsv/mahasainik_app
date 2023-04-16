import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mahasainik_app/UI/categories/sub_categories/sub_categories_screen.dart';
import 'package:mahasainik_app/networking/api_endpoints.dart';
import 'package:mahasainik_app/networking/trial_models/categories_model.dart';
import 'package:mahasainik_app/utils/color_assets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late String? token;
  Future<List<Categories>>? _categoriesFuture;

  Future<List<Categories>> getCategories() async {
    try {
      final tokenPref = await SharedPreferences.getInstance();
      token = tokenPref.getString('token');
      print('tokenpref: $token');
      final response = await http.get(
        Uri.parse(ApiEndpoints.getCategories),
      );
      if (response.statusCode == 200) {
        print(response.body);
        Iterable l = json.decode(response.body);
        List<Categories> categories = List<Categories>.from(
          l.map(
            (model) => Categories.fromJson(model),
          ),
        );
        return categories;
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
    _categoriesFuture = getCategories();
  }

  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await showDialog(
      context: context,
      builder: (context) => _showCustomDialog(context),
    );
    return exitResult ?? false;
  }

  AlertDialog _showCustomDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Please confirm'),
      content: const Text(
        'Do you want to exit the app?',
        style: TextStyle(
          color: AppColors.blackColor,
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text(
            'No',
            style: TextStyle(
              color: AppColors.blackColor,
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text(
            'Yes',
            style: TextStyle(
              color: AppColors.blackColor,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Categories',
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<List<Categories>>(
                future: _categoriesFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SubCategoriesScreen(
                                  categoryTitle: snapshot.data![index].name,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Image.network(
                                  snapshot.data![index].image,
                                  height: 100,
                                  fit: BoxFit.fill,
                                ),
                                Text(
                                  snapshot.data![index].name,
                                  style: const TextStyle(
                                    color: AppColors.blackColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
