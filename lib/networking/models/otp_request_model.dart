class OTPRequestModel {
  final String detail;
  final String otp;

  const OTPRequestModel({
    required this.detail,
    required this.otp,
  });

  factory OTPRequestModel.fromJson(Map<String, dynamic> json) {
    return OTPRequestModel(
      detail: json['detail'],
      otp: json['otp'],
    );
  }
}
