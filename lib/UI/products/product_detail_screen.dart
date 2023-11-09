import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:mahasainik_app/networking/api_endpoints.dart';
import 'package:mahasainik_app/networking/trial_models/add_to_cart_model.dart';
import 'package:mahasainik_app/networking/trial_models/best_selling_model.dart';
import 'package:mahasainik_app/networking/trial_models/sub_categories_model.dart'
    as subcat;
import 'package:mahasainik_app/utils/color_assets.dart';
import 'package:mahasainik_app/utils/image_assets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    Key? key,
    required this.result,
  }) : super(key: key);

  final subcat.Result result;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  Future<BestSellingModel>? _bestSellingModel;
  late String? token;
  int quantity = 0;

  Future<BestSellingModel> getBestSelling() async {
    try {
      final tokenPref = await SharedPreferences.getInstance();
      token = tokenPref.getString('token');
      print('tokenpref: $token');
      final response = await http.get(
        Uri.parse(ApiEndpoints.bestSelling),
        // headers: {
        //   'Authorization': token!,
        // },
      );
      if (response.statusCode == 200) {
        print(response.body);
        final bestSelling =
            BestSellingModel.fromJson(jsonDecode(response.body));
        print(bestSelling);
        return bestSelling;
      } else {
        throw 'Error fetching Best Selling';
      }
    } catch (e) {
      throw 'Error loading Best Selling.';
    }
  }

  Future<AddToCartModel> addItemToCart(int productId, int quantity) async {
    try {
      final tokenPref = await SharedPreferences.getInstance();
      token = tokenPref.getString('token');
      print('tokenpref: $token');
      print('productId: $productId, quantity: $quantity');

      final response = await http.post(
        Uri.parse(ApiEndpoints.addToCart),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token',
        },
        body: jsonEncode(<String, int>{
          'product_id': productId,
          'quantity': quantity,
        }),
      );
      if (response.statusCode == 200) {
        final addToCart = AddToCartModel.fromJson(jsonDecode(response.body));
        return addToCart;
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
    _bestSellingModel = getBestSelling();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: const Text('Product Details'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.result.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '₹${widget.result.price.inclTax}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.blackColor,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite_outline_rounded,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.primaryColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Image.network(
                            widget.result.image,
                            width: width,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Image.asset(AppImages.productOfferBanner),
                      const SizedBox(height: 20),
                      const SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Product Description',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.blackColor,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec egestas nisi ut finibus pellentesque. Etiam accumsan, purus ac faucibus vehicula, sapien erat viverra lacus, in faucibus neque orci vel lorem.',
                              style: TextStyle(
                                color: AppColors.blackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'MANUFACTURING DETAILS',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.blackColor,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Lorem ipsum dolor sit amet',
                              style: TextStyle(
                                color: AppColors.blackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SELLER INFORMATION',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.blackColor,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Lorem ipsum dolor sit amet',
                              style: TextStyle(
                                color: AppColors.blackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'FSSAI NUMBER',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.blackColor,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              widget.result.upc,
                              style: const TextStyle(
                                color: AppColors.blackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'FOR ANY ASSISTANCE CONTACT',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.blackColor,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'info@mahasainik.com',
                              style: TextStyle(
                                color: AppColors.blackColor,
                              ),
                            ),
                            Text(
                              '+91-9876543210',
                              style: TextStyle(
                                color: AppColors.blackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Image.asset(AppImages.offerBanner1),
                ),
                const SizedBox(height: 20),
                Image.asset(AppImages.paytmBanner),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        'Frequently Bought Together',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: SizedBox(
                    height: 300,
                    width: width,
                    child: FutureBuilder<BestSellingModel>(
                      future: _bestSellingModel,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.count,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Stack(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          height: 200,
                                          width: 200,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: AppColors.greyColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(18),
                                          ),
                                          child: Image.network(
                                            snapshot.data!.results[index].image,
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                        Text(
                                          snapshot.data!.results[index].title,
                                          style: const TextStyle(
                                            color: AppColors.blackColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          '₹${snapshot.data!.results[index].price.inclTax}',
                                          style: const TextStyle(
                                            color: AppColors.greyColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      top: 175,
                                      right: 74,
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.add,
                                            color: AppColors.whiteColor,
                                          ),
                                        ),
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
                  ),
                ),
                SizedBox(
                  height: 180,
                  child: Image.asset(AppImages.offerBannerFull),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Best Selling Services',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.blackColor,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'VIEW ALL',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.65,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          Stack(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    height: 220,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.greyColor,
                                      ),
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(18),
                                            topRight: Radius.circular(18),
                                          ),
                                          child: Image.asset(
                                            AppImages.electronicRepair,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          'Appliance and Electronic Repair',
                                          style: TextStyle(
                                            color: AppColors.blackColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          '₹799',
                                          style: TextStyle(
                                            color: AppColors.greyColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 195,
                                left: 100,
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.add,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    height: 220,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.greyColor,
                                      ),
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(18),
                                            topRight: Radius.circular(18),
                                          ),
                                          child: Image.asset(
                                            AppImages.electronicRepair,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          'Pest Control',
                                          style: TextStyle(
                                            color: AppColors.blackColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          '₹799',
                                          style: TextStyle(
                                            color: AppColors.greyColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 195,
                                left: 100,
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.add,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    height: 220,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.greyColor,
                                      ),
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(18),
                                            topRight: Radius.circular(18),
                                          ),
                                          child: Image.asset(
                                            AppImages.electronicRepair,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          'Full Home Deep Cleaning',
                                          style: TextStyle(
                                            color: AppColors.blackColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          '₹799',
                                          style: TextStyle(
                                            color: AppColors.greyColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 195,
                                left: 100,
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.add,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    height: 220,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.greyColor,
                                      ),
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(18),
                                            topRight: Radius.circular(18),
                                          ),
                                          child: Image.asset(
                                            AppImages.electronicRepair,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          'Plumber',
                                          style: TextStyle(
                                            color: AppColors.blackColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          '₹799',
                                          style: TextStyle(
                                            color: AppColors.greyColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 195,
                                left: 100,
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.add,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    Row(
                      children: [
                        const Spacer(),
                        SizedBox(
                          height: 80,
                          child: Image.asset(
                            AppImages.mahasainikLogoSmall,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'All Copyrights Reserved',
                      style: TextStyle(
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
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
                    const Spacer(),
                    Text(
                      '₹${widget.result.price.inclTax}',
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      child: const Icon(
                        FontAwesomeIcons.circlePlus,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Text(
                      quantity.toString(),
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 15),
                    InkWell(
                      onTap: () {
                        setState(() {
                          quantity--;
                        });
                      },
                      child: const Icon(
                        FontAwesomeIcons.circleMinus,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        if (quantity != 0) {
                          addItemToCart(widget.result.id, quantity);
                          Fluttertoast.showToast(
                            msg: 'Added to cart.',
                            toastLength: Toast.LENGTH_SHORT,
                          );
                        }
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
                          'Add to Cart',
                          style: TextStyle(
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
