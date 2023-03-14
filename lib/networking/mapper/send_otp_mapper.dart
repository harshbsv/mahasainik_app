import 'package:mahasainik_app/networking/models/send_otp_model.dart';
import 'package:mahasainik_app/networking/response_models/send_otp_response_model.dart';

SendOTPModel mapGenerateOtpModel(SendOTPResponseModel responseModel) {
  var result = SendOTPModel()
    ..details = responseModel.details
    ..otp = responseModel.otp;
  return result;
}
