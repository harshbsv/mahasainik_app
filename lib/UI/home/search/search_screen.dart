import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahasainik_app/bloc/homescreen_search/search_bloc.dart';
import 'package:mahasainik_app/utils/color_assets.dart';
import 'package:mahasainik_app/utils/constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchFieldController = TextEditingController();
  SearchBloc searchBloc = SearchBloc();

  @override
  void initState() {
    super.initState();
    searchBloc.add(SearchInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 290,
          child: TextField(
            controller: _searchFieldController,
            maxLines: 1,
            style: const TextStyle(
              color: AppColors.whiteColor,
            ),
            cursorHeight: 22,
            cursorColor: AppColors.whiteColor,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: AppColors.whiteColor,
                fontStyle: FontStyle.italic,
              ),
              hintText: AppConstants.searchBarHint,
            ),
            onSubmitted: (value) {
              if (_searchFieldController.text.isNotEmpty) {
                searchBloc.add(
                  SearchProductsEvent(
                    _searchFieldController.text.trim(),
                  ),
                );
              }
            },
            onChanged: (value) {
              if (_searchFieldController.text.isNotEmpty) {
                searchBloc.add(
                  SearchProductsEvent(
                    _searchFieldController.text.trim(),
                  ),
                );
              }
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<SearchBloc, SearchState>(
          bloc: searchBloc,
          builder: (context, state) {
            switch (state.runtimeType) {
              case SearchInitialState:
                return const Center(
                  child: Text('Search Products here'),
                );
              case SearchLoadingState:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case SearchSuccessState:
                final successState = state as SearchSuccessState;
                return SizedBox(
                  height: height,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: successState.responseModel.count,
                    itemBuilder: (context, index) {
                      if (successState.responseModel.count == 0) {
                        return const Center(
                          child: Text('No Products found.'),
                        );
                      } else {
                        return Text(
                          successState.responseModel.results[index].title,
                          style: const TextStyle(
                            fontSize: 18,
                            color: AppColors.blackColor,
                          ),
                        );
                        // return GestureDetector(
                        //   onTap: () {
                        //     // Navigator.of(context).push(
                        //     //   MaterialPageRoute(
                        //     //     builder: (context) => ProductDetailsScreen(
                        //     //       result: successState.responseModel!.results[index]!,
                        //     //     ),
                        //     //   ),
                        //     // );
                        //   },
                        //   child: ListTile(
                        //     leading: Image.network(
                        //       successState.responseModel.results[index].image,
                        //       height: 80,
                        //     ),
                        //     title: Text(
                        //       successState.responseModel.results[index].title,
                        //       style: const TextStyle(
                        //         fontSize: 18,
                        //         color: AppColors.blackColor,
                        //       ),
                        //     ),
                        //     subtitle: Text(
                        //       successState
                        //           .responseModel.results[index].price.inclTax,
                        //       style: const TextStyle(
                        //         fontSize: 16,
                        //         color: AppColors.blackColor,
                        //       ),
                        //     ),
                        //   ),
                        // );
                      }
                    },
                  ),
                );
              default:
                return const Center(
                  child: Text('Error searching data.'),
                );
            }
          },
        ),
      ),
    );
  }
}
