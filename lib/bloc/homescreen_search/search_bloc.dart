import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:mahasainik_app/networking/response_models/search_response_model.dart';
import 'package:mahasainik_app/networking/retrofit.dart';
import 'package:mahasainik_app/utils/preferences_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  ApiClient apiClient =
      ApiClient(Dio(BaseOptions(contentType: Headers.jsonContentType)));
  Logger logger = Logger();
  SearchBloc() : super(SearchInitialState()) {
    on<SearchInitialEvent>(searchInitialEvent);
    on<SearchProductsEvent>(searchProductsEvent);
    on<SearchLoadingEvent>(searchLoadingEvent);
    on<SearchSuccessEvent>(searchSuccessEvent);
    on<SearchErrorEvent>(searchErrorEvent);
  }

  FutureOr<void> searchInitialEvent(
      SearchInitialEvent event, Emitter<SearchState> emit) {
    emit(SearchInitialState());
  }

  FutureOr<void> searchLoadingEvent(
      SearchLoadingEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());
  }

  FutureOr<void> searchSuccessEvent(
      SearchSuccessEvent event, Emitter<SearchState> emit) {}

  FutureOr<void> searchErrorEvent(
      SearchErrorEvent event, Emitter<SearchState> emit) {}

  FutureOr<void> searchProductsEvent(
      SearchProductsEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());
    final prefs = await SharedPreferences.getInstance();
    int storeId = int.parse(prefs.getString(kStoreId) ?? '1');
    logger.i('STORE ID SEARCH: $storeId');
    logger.i('SEARCH QUERY: ${event.searchQuery}');
    await apiClient
        .getSearchedProducts(storeId, event.searchQuery, 100, 0)
        .then((value) {
      logger.i('SEARCH RESPONSE: $value');
      emit(SearchSuccessState(value));
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response;
          logger.e("Search Error : ${res.toString()}");
          emit(SearchErrorState(res.toString()));
          break;
        default:
          break;
      }
    });
  }
}
