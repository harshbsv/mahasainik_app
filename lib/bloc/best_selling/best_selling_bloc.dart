import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:mahasainik_app/networking/response_models/best_selling_response_model.dart';
import 'package:mahasainik_app/networking/retrofit.dart';
import 'package:mahasainik_app/utils/preferences_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'best_selling_event.dart';
part 'best_selling_state.dart';

class BestSellingBloc extends Bloc<BestSellingEvent, BestSellingState> {
  ApiClient apiClient =
      ApiClient(Dio(BaseOptions(contentType: Headers.jsonContentType)));
  Logger logger = Logger();
  BestSellingBloc() : super(BestSellingInitialState()) {
    on<BestSellingInitialEvent>(bestSellingInitialEvent);
    on<BestSellingLoadingEvent>(bestSellingLoadingEvent);
    on<BestSellingSuccessEvent>(bestSellingSuccessEvent);
    on<BestSellingErrorEvent>(bestSellingErrorEvent);
  }

  FutureOr<void> bestSellingInitialEvent(
      BestSellingInitialEvent event, Emitter<BestSellingState> emit) {}

  FutureOr<void> bestSellingLoadingEvent(
      BestSellingLoadingEvent event, Emitter<BestSellingState> emit) async {
    emit(BestSellingLoadingState());
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(kLoginToken);
    int storeId = int.parse(prefs.getString(kStoreId) ?? '1');
    logger.i('AUTH TOKEN: $token');
    logger.i('STORE ID BEST SELLING: $storeId');
    await apiClient.getBestSelling(token!, storeId, 20, 0).then((value) {
      logger.i('Best Selling: ${value.toJson()}');
      emit(BestSellingSuccessState(value));
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response;
          logger.e("Best Selling Error : ${res.toString()}");
          emit(BestSellingErrorState(res.toString()));
          break;
        default:
          break;
      }
    });
  }

  FutureOr<void> bestSellingSuccessEvent(
      BestSellingSuccessEvent event, Emitter<BestSellingState> emit) {}

  FutureOr<void> bestSellingErrorEvent(
      BestSellingErrorEvent event, Emitter<BestSellingState> emit) {}
}
