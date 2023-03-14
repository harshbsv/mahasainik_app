import 'package:fluttertoast/fluttertoast.dart';
import 'package:mahasainik_app/error/app_exception.dart';
import 'package:mahasainik_app/networking/api_endpoints.dart';
import 'package:mahasainik_app/networking/api_response_wrapper.dart';
import 'package:mahasainik_app/networking/mapper/send_otp_mapper.dart';
import 'package:mahasainik_app/networking/models/send_otp_model.dart';
import 'package:mahasainik_app/networking/request_models/send_otp_request_model.dart';
import 'package:mahasainik_app/networking/retro_client.dart';
import 'package:mahasainik_app/networking/service_manager.dart';

class ApiRepository {
  ApiClient? _apiClient;
  ApiRepository({enableInterceptor = true}) {
    var dioClient =
        ServiceManager.get().getDioClient(baseUrl: ApiEndpoints.baseUrl);
    _apiClient = ApiClient(dioClient);
  }

  Future<ApiResponseWrapper<SendOTPModel?>> sendOTP(
      SendOTPRequestModel sendOTPRequestModel) async {
    try {
      var response = await _apiClient!.sendOTP(sendOTPRequestModel);
      String otpNumber = response.otp.toString();
      print('otpNumber: $otpNumber');
      Fluttertoast.showToast(msg: otpNumber, toastLength: Toast.LENGTH_LONG);
      return ApiResponseWrapper()..setData(mapGenerateOtpModel(response));
    } on Exception catch (error) {
      return ApiResponseWrapper()..setException(ExceptionHandler(error));
    }
  }
}
