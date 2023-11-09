import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:mahasainik_app/networking/response_models/categories_response_model.dart';
import 'package:mahasainik_app/networking/retrofit.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  ApiClient apiClient =
      ApiClient(Dio(BaseOptions(contentType: Headers.jsonContentType)));
  Logger logger = Logger();
  CategoriesBloc() : super(CategoriesInitialState()) {
    on<CategoriesInitialEvent>(categoriesInitialEvent);
    on<CategoriesLoadingEvent>(categoriesLoadingEvent);
    on<CategoriesSuccessEvent>(categoriesSuccessEvent);
    on<CategoriesErrorEvent>(categoriesErrorEvent);
  }

  FutureOr<void> categoriesInitialEvent(
      CategoriesInitialEvent event, Emitter<CategoriesState> emit) {}

  FutureOr<void> categoriesLoadingEvent(
      CategoriesLoadingEvent event, Emitter<CategoriesState> emit) async {
    emit(CategoriesLoadingState());
    await apiClient.getCategories().then((value) {
      logger.i('Categories: ${value.toString()}');
      emit(CategoriesSuccessState(value));
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response;
          logger.e('Categories Error: ${res.toString()}');
          emit(CategoriesErrorState(res.toString()));
          break;
        default:
          break;
      }
    });
  }

  FutureOr<void> categoriesSuccessEvent(
      CategoriesSuccessEvent event, Emitter<CategoriesState> emit) {}

  FutureOr<void> categoriesErrorEvent(
      CategoriesErrorEvent event, Emitter<CategoriesState> emit) {}
}
