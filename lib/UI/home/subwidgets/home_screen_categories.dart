import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahasainik_app/UI/categories/categories_screen.dart';
import 'package:mahasainik_app/UI/categories/sub_categories/sub_categories_screen.dart';
import 'package:mahasainik_app/bloc/categories/categories_bloc.dart';
import 'package:mahasainik_app/utils/color_assets.dart';

class HomeScreenCategories extends StatefulWidget {
  const HomeScreenCategories({super.key});

  @override
  State<HomeScreenCategories> createState() => _HomeScreenCategoriesState();
}

class _HomeScreenCategoriesState extends State<HomeScreenCategories> {
  bool _isProductsEnabled = true;
  bool _isServicesEnabled = false;
  bool _showCategories = true;
  bool _showServices = false;
  final CategoriesBloc categoriesBloc = CategoriesBloc();

  @override
  void initState() {
    super.initState();
    categoriesBloc.add(CategoriesLoadingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Shop by Category',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackColor,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CategoriesScreen(),
                    ),
                  );
                },
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
          Row(
            children: [
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    if (_isProductsEnabled) {
                      _isProductsEnabled = false;
                      _showCategories = false;
                      _isServicesEnabled = true;
                      _showServices = true;
                    } else {
                      _isProductsEnabled = true;
                      _showCategories = true;
                      _isServicesEnabled = false;
                      _showServices = false;
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  backgroundColor: _isProductsEnabled
                      ? AppColors.brownColor
                      : AppColors.whiteColor,
                  foregroundColor: _isProductsEnabled
                      ? AppColors.whiteColor
                      : AppColors.greyColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 42,
                    vertical: 14,
                  ),
                ),
                child: const Text(
                  'PRODUCTS',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    if (_isServicesEnabled) {
                      _isServicesEnabled = false;
                      _showServices = false;
                      _isProductsEnabled = true;
                      _showCategories = true;
                    } else {
                      _isServicesEnabled = true;
                      _showServices = true;
                      _isProductsEnabled = false;
                      _showCategories = false;
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  backgroundColor: _isServicesEnabled
                      ? AppColors.brownColor
                      : AppColors.whiteColor,
                  foregroundColor: _isServicesEnabled
                      ? AppColors.whiteColor
                      : AppColors.greyColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 42,
                    vertical: 14,
                  ),
                ),
                child: const Text(
                  'SERVICES',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _showCategories
              ? BlocBuilder<CategoriesBloc, CategoriesState>(
                  bloc: categoriesBloc,
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case CategoriesLoadingState:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case CategoriesSuccessState:
                        final success = state as CategoriesSuccessState;
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.45,
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: success.responseModel.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => SubCategoriesScreen(
                                      categoryTitle:
                                          success.responseModel[index].name!,
                                    ),
                                  ),
                                );
                              },
                              child: SizedBox(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: AppColors.lightGreenHue,
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 30.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          child: Image.network(
                                            success.responseModel[index].image!,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      success.responseModel[index].name!,
                                      style: const TextStyle(
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      case CategoriesErrorState:
                        final error = state as CategoriesErrorState;
                        return Center(
                          child: Text(error.error),
                        );
                      default:
                        return const SizedBox();
                    }
                  },
                )
              : const SizedBox(
                  height: 411,
                  child: Center(
                    child: Text(
                      'Services are coming soon',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
