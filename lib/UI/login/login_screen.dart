import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mahasainik_app/UI/login/enter_otp_screen.dart';
import 'package:mahasainik_app/networking/api_endpoints.dart';
import 'package:mahasainik_app/networking/trial_models/generate_otp_model.dart';
import 'package:mahasainik_app/utils/color_assets.dart';
import 'package:mahasainik_app/utils/common_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _mobileController = TextEditingController();
  late String? mobileNumber;
  GenerateOtpModel? generateOtpModel;

  Future<GenerateOtpModel> sendOTPRequest(String mobileNumber) async {
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.sendOTP),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'mobile': '+91${mobileNumber}',
        }),
      );
      if (response.statusCode == 200) {
        final generateOtpModel =
            GenerateOtpModel.fromJson(jsonDecode(response.body));
        print('OTP: ${generateOtpModel.otp}');
        Fluttertoast.showToast(
          msg: 'OTP: ${generateOtpModel.otp}',
          toastLength: Toast.LENGTH_LONG,
        );
        return generateOtpModel;
      } else {
        throw 'Error making request';
      }
    } catch (e) {
      throw 'Error making request';
    }
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
                        controller: _mobileController,
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Enter 10-digit mobile number',
                        ),
                        validator: (value) {
                          mobileNumber = value!;
                          validateMobile(mobileNumber);
                        },
                      ),
                      const SizedBox(height: 70),
                      ElevatedButton(
                        onPressed: () {
                          sendOTPRequest(_mobileController.text);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => OTPInputScreen(
                                mobileNumber: '+91${_mobileController.text}',
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Send OTP',
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
