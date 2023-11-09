import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:mahasainik_app/networking/response_models/products_response_model.dart';
import 'package:mahasainik_app/networking/retrofit.dart';
import 'package:mahasainik_app/utils/preferences_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  Logger logger = Logger();
  ApiClient apiClient =
      ApiClient(Dio(BaseOptions(contentType: Headers.jsonContentType)));
  ProductsBloc() : super(ProductsInitialState()) {
    on<ProductsInitialEvent>(productsInitialEvent);
    on<ProductsLoadingEvent>(productsLoadingEvent);
    on<ProductsSuccessEvent>(productsSuccessEvent);
    on<ProductsErrorEvent>(productsErrorEvent);
  }

  FutureOr<void> productsInitialEvent(
      ProductsInitialEvent event, Emitter<ProductsState> emit) {}

  FutureOr<void> productsLoadingEvent(
      ProductsLoadingEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsLoadingState());
    final prefs = await SharedPreferences.getInstance();
    int storeId = int.parse(prefs.getString(kStoreId) ?? '1');
    logger.i('STORE ID PRODUCTS: $storeId');
    await apiClient
        .getProducts(storeId, 100, 0)
        .then((value) {})
        .catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response;
          logger.e("Products Error : ${res.toString()}");
          emit(ProductsErrorState(res.toString()));
          break;
        default:
          break;
      }
    });
  }

  FutureOr<void> productsSuccessEvent(
      ProductsSuccessEvent event, Emitter<ProductsState> emit) {}

  FutureOr<void> productsErrorEvent(
      ProductsErrorEvent event, Emitter<ProductsState> emit) {}
}
