import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
        headers: {
          'Authorization': token!,
        },
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Categories',
        ),
        centerTitle: true,
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
                      return Container(
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
    );
  }
}
