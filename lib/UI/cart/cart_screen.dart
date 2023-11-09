import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mahasainik_app/UI/checkout/checkout_screen.dart';
import 'package:mahasainik_app/networking/api_endpoints.dart';
import 'package:mahasainik_app/networking/trial_models/basket_model.dart';
import 'package:mahasainik_app/networking/trial_models/checkout_model.dart';
import 'package:mahasainik_app/networking/trial_models/get_profile_model.dart';
import 'package:mahasainik_app/utils/color_assets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Future<List<BasketModel>> getBasket() async {
    try {
      final tokenPref = await SharedPreferences.getInstance();
      String? token = tokenPref.getString('token');
      print('tokenpref: $token');
      final response =
          await http.get(Uri.parse(ApiEndpoints.getBaskets), headers: {
        'Authorization': 'Token $token',
      });
      print('response : ${response.body.toString()}');
      if (response.statusCode == 200) {
        Iterable l = json.decode(response.body);
        List<BasketModel> basket = List<BasketModel>.from(
          l.map(
            (model) => BasketModel.fromJson(model),
          ),
        );
        // final basket =
        //     BasketModel.fromJson(jsonDecode(response.body.toString()));
        print('BASKET: $basket');
        return basket;
      } else {
        throw 'status code other than 200';
      }
    } catch (e) {
      throw 'Exception fetching basket.';
    }
  }

  Future<GetUserProfile> getUserProfile() async {
    try {
      final tokenPref = await SharedPreferences.getInstance();
      String? token = tokenPref.getString('token');
      print('tokenpref: $token');
      final response =
          await http.get(Uri.parse(ApiEndpoints.getProfile), headers: {
        'Authorization': 'Token $token',
      });
      print('response : ${response.body.toString()}');
      if (response.statusCode == 200) {
        final userProfile = GetUserProfile.fromJson(jsonDecode(response.body));
        print('userprofile email: ${userProfile.email}');
        tokenPref.setString('user_email', userProfile.email);
        tokenPref.setString('first_name', userProfile.firstName);
        tokenPref.setString('last_name', userProfile.lastName);
        tokenPref.setString('line1', userProfile.address[0].line1);
        tokenPref.setString('line2', userProfile.address[0].line2);
        tokenPref.setString('line3', userProfile.address[0].line3);
        tokenPref.setString('line4', userProfile.address[0].line4);
        tokenPref.setString('notes', userProfile.address[0].notes);
        tokenPref.setString('phone_number', userProfile.address[0].phoneNumber);
        tokenPref.setString('postcode', userProfile.address[0].postcode);
        tokenPref.setString('state', userProfile.address[0].state);
        tokenPref.setString('title', userProfile.address[0].title);
        return userProfile;
      } else {
        throw 'status code other than 200';
      }
    } catch (e) {
      throw 'Exception fetching user profile.';
    }
  }

  Future<CheckoutModel> checkout(
    int basketId,
    String total,
  ) async {
    try {
      getUserProfile();
      final tokenPref = await SharedPreferences.getInstance();
      String? token = tokenPref.getString('token');
      String? user_email = tokenPref.getString('user_email');
      String? first_name = tokenPref.getString('first_name');
      String? last_name = tokenPref.getString('last_name');
      String? line1 = tokenPref.getString('line1');
      String? line2 = tokenPref.getString('line2');
      String? line3 = tokenPref.getString('line3');
      String? line4 = tokenPref.getString('line4');
      String? notes = tokenPref.getString('notes');
      String? phone_number = tokenPref.getString('phone_number');
      String? postcode = tokenPref.getString('postcode');
      String? state = tokenPref.getString('state');
      String? title = tokenPref.getString('title');
      print('tokenpref: $token');
      print('user_email: $last_name');
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.checkout),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token',
        },
        body: jsonEncode(<String, dynamic>{
          "basket": "https://mahasainikstore.com/api/baskets/$basketId/",
          "guest_email": user_email,
          "total": total,
          "shipping_charge": {
            "currency": "INR",
            "excl_tax": "0.00",
            "tax": "0.00"
          },
          "shipping_method_code": "no-shipping-required",
          "shipping_address": {
            "country": "https://mahasainikstore.com/api/countries/IN/",
            "first_name": first_name,
            "last_name": last_name,
            "line1": line1,
            "line2": line2,
            "line3": line3,
            "line4": line4,
            "notes": notes,
            "phone_number": phone_number,
            "postcode": postcode,
            "state": state,
            "title": title
          },
          "billing_address": {
            "country": "https://mahasainikstore.com/api/countries/IN/",
            "first_name": first_name,
            "last_name": last_name,
            "line1": line1,
            "line2": line2,
            "line3": line3,
            "line4": line4,
            "notes": notes,
            "phone_number": phone_number,
            "postcode": postcode,
            "state": state,
            "title": title
          }
        }),
      );
      if (response.statusCode == 200) {
        final checkout = CheckoutModel.fromJson(jsonDecode(response.body));
        return checkout;
      } else {
        throw 'Error making request';
      }
    } catch (e) {
      throw 'Error making request';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Cart',
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<BasketModel>>(
        future: getBasket(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
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
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data![0].lines.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: ListTile(
                            title: Text(
                              snapshot.data![0].lines[index].product,
                              style: const TextStyle(
                                fontSize: 18,
                                color: AppColors.blackColor,
                              ),
                            ),
                            subtitle: Text(
                              'Quantity: ${snapshot.data![0].lines[index].quantity}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.blackColor,
                              ),
                            ),
                            trailing: Text(
                              snapshot.data![0].lines[index].priceInclTax,
                              style: const TextStyle(
                                fontSize: 18,
                                color: AppColors.blackColor,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: double.infinity,
                      child: Container(
                        height: 55,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 30),
                            Text(
                              '₹${snapshot.data![0].totalInclTax}',
                              style: const TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                checkout(
                                  snapshot.data![0].id,
                                  snapshot.data![0].totalInclTax,
                                ).then((value) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CheckoutScreen(
                                        checkoutModel: value,
                                      ),
                                    ),
                                  );
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Text(
                                  'Checkout',
                                  style: TextStyle(
                                    color: AppColors.blackColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 30),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
