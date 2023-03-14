import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mahasainik_app/UI/main_page/main_page.dart';
import 'package:mahasainik_app/networking/api_endpoints.dart';
import 'package:mahasainik_app/networking/trial_models/otp_login_model.dart';
import 'package:mahasainik_app/utils/color_assets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPInputScreen extends StatefulWidget {
  const OTPInputScreen({
    Key? key,
    required this.mobileNumber,
  }) : super(key: key);

  final String mobileNumber;

  @override
  State<OTPInputScreen> createState() => _OTPInputScreenState();
}

class _OTPInputScreenState extends State<OTPInputScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _otpController = TextEditingController();
  late String? otp;

  Future<OtpLoginModel> sendTokenRequest(
      String mobileNumber, String otp) async {
    try {
      var response = await http.post(
        Uri.parse(ApiEndpoints.verifyOTP),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'mobile': mobileNumber,
          'token': otp,
        }),
      );
      if (response.statusCode == 200) {
        final otpLoginModel = OtpLoginModel.fromJson(jsonDecode(response.body));
        print('token: ${otpLoginModel.token}');
        final tokenPref = await SharedPreferences.getInstance();
        tokenPref.setString('token', otpLoginModel.token);
        Fluttertoast.showToast(
          msg: 'TOKEN: ${otpLoginModel.token}',
          toastLength: Toast.LENGTH_LONG,
        );
        navigateToMain();
        return otpLoginModel;
      } else {
        throw 'Error making request';
      }
    } catch (e) {
      throw 'Error making request';
    }
  }

  void navigateToMain() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MainPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 300),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _otpController,
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Enter OTP',
                        ),
                      ),
                      const SizedBox(height: 70),
                      ElevatedButton(
                        onPressed: () {
                          sendTokenRequest(
                              widget.mobileNumber, _otpController.text);
                        },
                        child: const Text(
                          'Sign In',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
