import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahasainik_app/bloc/best_selling/best_selling_bloc.dart';
import 'package:mahasainik_app/utils/color_assets.dart';

class HomeScreenBestSelling extends StatefulWidget {
  const HomeScreenBestSelling({super.key});

  @override
  State<HomeScreenBestSelling> createState() => _HomeScreenBestSellingState();
}

class _HomeScreenBestSellingState extends State<HomeScreenBestSelling> {
  final BestSellingBloc bestSellingBloc = BestSellingBloc();

  @override
  void initState() {
    super.initState();
    bestSellingBloc.add(BestSellingLoadingEvent());
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: SizedBox(
        height: 300,
        width: width,
        child: BlocBuilder<BestSellingBloc, BestSellingState>(
          bloc: bestSellingBloc,
          builder: (context, state) {
            switch (state.runtimeType) {
              case BestSellingLoadingState:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case BestSellingSuccessState:
                final success = state as BestSellingSuccessState;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: success.responseModel.count,
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
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Image.network(
                                  success.responseModel.results![index].image!,
                                ),
                              ),
                              const SizedBox(height: 30),
                              Text(
                                success.responseModel.results![index].title!,
                                style: const TextStyle(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              // Row(
                              //   children: [
                              //     Text(
                              //       '₹${snapshot.data!.results[index].price.exclTax}',
                              //       style: const TextStyle(
                              //         color: AppColors.greyColor,
                              //         fontWeight: FontWeight.w500,
                              //         fontSize: 16,
                              //         decoration:
                              //             TextDecoration.lineThrough,
                              //       ),
                              //       textAlign: TextAlign.center,
                              //     ),
                              //     const SizedBox(width: 8),
                              //     Text(
                              //       '₹${snapshot.data!.results[index].price.inclTax}',
                              //       style: const TextStyle(
                              //         color: AppColors.greyColor,
                              //         fontWeight: FontWeight.w500,
                              //         fontSize: 16,
                              //       ),
                              //       textAlign: TextAlign.center,
                              //     ),
                              //   ],
                              // ),
                              Text(
                                '₹${success.responseModel.results![index].price!.incl_tax!}',
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
                    );
                  },
                );
              case BestSellingErrorState:
                final error = state as BestSellingErrorState;
                return Center(
                  child: Text(error.error),
                );
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
