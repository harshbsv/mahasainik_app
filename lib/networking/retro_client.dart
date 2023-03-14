import 'package:dio/dio.dart';
import 'package:mahasainik_app/networking/api_endpoints.dart';
import 'package:mahasainik_app/networking/request_models/send_otp_request_model.dart';
import 'package:mahasainik_app/networking/response_models/send_otp_response_model.dart';
import 'package:retrofit/http.dart';

part 'retro_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio) {
    return _ApiClient(dio);
  }

  @POST(ApiEndpoints.sendOTP)
  Future<SendOTPResponseModel> sendOTP(
    @Body() SendOTPRequestModel sendOTPResponseModel,
  );
}
