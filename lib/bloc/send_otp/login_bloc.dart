import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:mahasainik_app/networking/request_models/send_otp_request_model.dart';
import 'package:mahasainik_app/networking/response_models/send_otp_response_model.dart';
import 'package:mahasainik_app/networking/retrofit.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  ApiClient apiClient =
      ApiClient(Dio(BaseOptions(contentType: Headers.jsonContentType)));
  Logger logger = Logger();
  LoginBloc() : super(LoginInitialState()) {
    on<LoginInitialEvent>(loginInitialEvent);
    on<LoginLoadingEvent>(loginLoadingEvent);
    on<LoginSuccessEvent>(loginSuccessEvent);
    on<LoginErrorEvent>(loginErrorEvent);
  }

  FutureOr<void> loginInitialEvent(
      LoginInitialEvent event, Emitter<LoginState> emit) {
    emit(LoginInitialState());
  }

  FutureOr<void> loginLoadingEvent(
      LoginLoadingEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    logger.i('MOBILE NUMBER: ${event.mobile}');
    var requestModel = SendOtpRequestModel(mobile: event.mobile);
    await apiClient
        .sendOTP(
      requestModel,
    )
        .then((value) {
      logger.i('SEND OTP: ${value.toJson()}');
      Fluttertoast.showToast(
        msg: '${value.detail}: ${value.otp}',
        toastLength: Toast.LENGTH_LONG,
      );
      emit(LoginSuccessState(value));
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response;
          logger.e("SEND OTP Error : ${res.toString()}");
          emit(LoginErrorState(res.toString()));
          break;
        default:
          break;
      }
    });
  }

  FutureOr<void> loginSuccessEvent(
      LoginSuccessEvent event, Emitter<LoginState> emit) {}

  FutureOr<void> loginErrorEvent(
      LoginErrorEvent event, Emitter<LoginState> emit) {}
}
