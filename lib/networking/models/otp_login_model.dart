class OTPLoginModel {
  final String token;

  const OTPLoginModel({
    required this.token,
  });

  factory OTPLoginModel.fromJson(Map<String, dynamic> json) {
    return OTPLoginModel(
      token: json['token'],
    );
  }
}
