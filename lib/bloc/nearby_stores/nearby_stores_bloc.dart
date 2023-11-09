import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:mahasainik_app/networking/request_models/nearby_store_request_model.dart';
import 'package:mahasainik_app/networking/response_models/nearby_stores_response_model.dart';
import 'package:mahasainik_app/networking/retrofit.dart';
import 'package:mahasainik_app/utils/preferences_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'nearby_stores_event.dart';
part 'nearby_stores_state.dart';

class NearbyStoresBloc extends Bloc<NearbyStoresEvent, NearbyStoresState> {
  ApiClient apiClient =
      ApiClient(Dio(BaseOptions(contentType: Headers.jsonContentType)));
  Logger logger = Logger();
  NearbyStoresBloc() : super(NearbyStoresInitalState()) {
    on<NearbyStoresLoadingEvent>(nearbyStoresLoadingEvent);
    on<NearbyStoresSuccessEvent>(nearbyStoresSuccessEvent);
    on<NearbyStoresErrorEvent>(nearbyStoresErrorEvent);
  }

  FutureOr<void> nearbyStoresLoadingEvent(
      NearbyStoresLoadingEvent event, Emitter<NearbyStoresState> emit) async {
    emit(NearbyStoresLoadingState());
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(kLoginToken);
    logger.i('AUTH TOKEN Nearby: $token');
    var requestModel = NearbyStoresRequestModel(
      latitude: event.latitude,
      longitude: event.longitude,
    );
    logger.i(
        'LAT LONG NEARBY STORES: ${requestModel.latitude}, ${requestModel.longitude}');
    await apiClient.getNearbyStore(token!, requestModel).then((value) {
      if (value.store_id.isEmpty || value.store_id == null) {
        logger.i('Nearby Stores Response: ${value.toJson()} store_id empty');
        prefs.setString(kStoreId, '1');
        emit(NearbyStoresSuccessState(value));
      } else {
        logger.i('Nearby Stores Response: ${value.toJson()}');
        prefs.setString(kStoreId, value.store_id);
        emit(NearbyStoresSuccessState(value));
      }
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response;
          logger.e("Nearby Stores Error : ${res.toString()}");
          emit(NearbyStoresErrorState(res.toString()));
          break;
        default:
          break;
      }
    });
  }

  FutureOr<void> nearbyStoresSuccessEvent(
      NearbyStoresSuccessEvent event, Emitter<NearbyStoresState> emit) {}

  FutureOr<void> nearbyStoresErrorEvent(
      NearbyStoresErrorEvent event, Emitter<NearbyStoresState> emit) {}
}
