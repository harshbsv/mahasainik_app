import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahasainik_app/bloc/login/login_event.dart';
import 'package:mahasainik_app/bloc/login/login_state.dart';
import 'package:mahasainik_app/error/app_error.dart';
import 'package:mahasainik_app/networking/api_repository.dart';
import 'package:mahasainik_app/networking/api_response_wrapper.dart';
import 'package:mahasainik_app/networking/models/send_otp_model.dart';
import 'package:mahasainik_app/networking/request_models/send_otp_request_model.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(OtpLoginState.loading('message'));
  ApiRepository apiRepository = ApiRepository();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is OtpLoginEvent) {
      var completePhoneNumber = '+91${event.phoneNumber}';
      print('complete phone number = $completePhoneNumber');
      try {
        var requestModel = SendOTPRequestModel(completePhoneNumber);
        ApiResponseWrapper<SendOTPModel?> response =
            await apiRepository.sendOTP(requestModel);
        if (response.getData != null) {
          if (response.getData!.otp != null) {
            yield OtpLoginState.completed(
              isValidNumber: true,
              mobileNumber: event.phoneNumber,
            );
          } else {
            yield OtpLoginState.completed(
                isValidNumber: false,
                mobileNumber: event.phoneNumber,
                errorMessage: response.getAppException!
                            .getDioError()!
                            .response!
                            .data?['message'] !=
                        null
                    ? response.getAppException!
                        .getDioError()!
                        .response!
                        .data['message']
                    : response.getAppException!
                            .getDioError()!
                            .response!
                            .data['message'] ??
                        'Something went wrong');
          }
        } else if (response.getAppException != null) {
          yield OtpLoginState.completed(
              isValidNumber: false,
              mobileNumber: event.phoneNumber,
              errorMessage: response.getAppException!
                          .getDioError()!
                          .response!
                          .data?['message'] !=
                      null
                  ? response.getAppException!
                      .getDioError()!
                      .response!
                      .data['message']
                  : response.getAppException!
                          .getDioError()!
                          .response!
                          .data['message'] ??
                      'Something went wrong');
        } else {
          yield OtpLoginState.error(
              AppError.withApiException(response.getAppException));
        }
      } catch (e) {
        yield OtpLoginState.error(AppError.defaultException());
      }
    }
  }
}
