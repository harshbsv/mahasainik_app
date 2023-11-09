import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:mahasainik_app/networking/response_models/user_profile_response_model.dart';
import 'package:mahasainik_app/networking/retrofit.dart';
import 'package:mahasainik_app/utils/preferences_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ApiClient apiClient =
      ApiClient(Dio(BaseOptions(contentType: Headers.jsonContentType)));
  Logger logger = Logger();
  ProfileBloc() : super(ProfileInitialState()) {
    on<ProfileInitialEvent>(profileInitialEvent);
    on<ProfileLoadingEvent>(profileLoadingEvent);
    on<ProfileSuccessEvent>(profileSuccessEvent);
    on<ProfileUpdatedEvent>(profileUpdatedEvent);
    on<ProfileErrorEvent>(profileErrorEvent);
  }

  FutureOr<void> profileInitialEvent(
      ProfileInitialEvent event, Emitter<ProfileState> emit) {
    emit(ProfileInitialState());
  }

  FutureOr<void> profileLoadingEvent(
      ProfileLoadingEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    final prefs = await SharedPreferences.getInstance();
    String? token = 'Token ${prefs.getString(kLoginToken)}';
    logger.i('Get User Profile token: $token');
    await apiClient.getProfile(token!).then((value) {
      logger.i('User Profile Data : ${value.toJson()}');
      emit(ProfileSuccessState(value));
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response;
          logger.e("User Profile Error : ${res.toString()}");
          emit(ProfileErrorState(res.toString()));
          break;
        default:
          break;
      }
    });
  }

  FutureOr<void> profileSuccessEvent(
      ProfileSuccessEvent event, Emitter<ProfileState> emit) {}

  FutureOr<void> profileUpdatedEvent(
      ProfileUpdatedEvent event, Emitter<ProfileState> emit) {}

  FutureOr<void> profileErrorEvent(
      ProfileErrorEvent event, Emitter<ProfileState> emit) {}
}
