import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:mahasainik_app/networking/request_models/verify_otp_request_model.dart';
import 'package:mahasainik_app/networking/response_models/verify_otp_response_model.dart';
import 'package:mahasainik_app/networking/retrofit.dart';
import 'package:mahasainik_app/utils/preferences_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'verify_otp_event.dart';
part 'verify_otp_state.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  ApiClient apiClient =
      ApiClient(Dio(BaseOptions(contentType: Headers.jsonContentType)));
  Logger logger = Logger();
  VerifyOtpBloc() : super(VerifyOtpInitialState()) {
    on<VerifyOtpInitialEvent>(verifyOtpInitialEvent);
    on<VerifyOtpLoadingEvent>(verifyOtpLoadingEvent);
    on<VerifyOtpSuccessEvent>(verifyOtpSuccessEvent);
    on<VerifyOtpErrorEvent>(verifyOtpErrorEvent);
  }

  FutureOr<void> verifyOtpInitialEvent(
      VerifyOtpInitialEvent event, Emitter<VerifyOtpState> emit) {}

  FutureOr<void> verifyOtpLoadingEvent(
      VerifyOtpLoadingEvent event, Emitter<VerifyOtpState> emit) async {
    emit(VerifyOtpLoadingState());
    var requestModel = VerifyOtpRequestModel(
      mobile: event.mobile,
      token: event.otp,
    );
    final prefs = await SharedPreferences.getInstance();
    apiClient.verifyOTP(requestModel).then((value) {
      logger.i('Verify OTP: ${value.toJson()}');
      prefs.setString(kLoginToken, value.token!);
      prefs.setBool(kUserLoginStatus, true);
      Fluttertoast.showToast(
        msg: 'Logged in Successfully.',
        toastLength: Toast.LENGTH_SHORT,
      );
      emit(VerifyOtpSuccessState(value));
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response;
          logger.e("Verify OTP Error : ${res.toString()}");
          emit(VerifyOtpErrorState(res.toString()));
          break;
        default:
          break;
      }
    });
  }

  FutureOr<void> verifyOtpSuccessEvent(
      VerifyOtpSuccessEvent event, Emitter<VerifyOtpState> emit) {}

  FutureOr<void> verifyOtpErrorEvent(
      VerifyOtpErrorEvent event, Emitter<VerifyOtpState> emit) {}
}
