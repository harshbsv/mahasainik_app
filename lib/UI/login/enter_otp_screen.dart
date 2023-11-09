import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahasainik_app/UI/main_page/main_page.dart';
import 'package:mahasainik_app/bloc/verify_otp/verify_otp_bloc.dart';
import 'package:mahasainik_app/utils/color_assets.dart';
import 'package:mahasainik_app/utils/image_assets.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();
  final VerifyOtpBloc verifyOtpBloc = VerifyOtpBloc();

  @override
  void initState() {
    super.initState();
    verifyOtpBloc.add(VerifyOtpInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: BlocConsumer<VerifyOtpBloc, VerifyOtpState>(
          bloc: verifyOtpBloc,
          listener: (context, state) {
            if (state is VerifyOtpSuccessState ||
                state is VerifyOtpLoadingState) {
              // Fluttertoast.showToast(
              //   msg: state.responseModel.token!,
              //   toastLength: Toast.LENGTH_SHORT,
              // );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const MainPage(),
                ),
              );
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case VerifyOtpInitialState:
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 60),
                      Image.asset(
                        AppImages.mahasainikLogoWBG,
                        height: 76,
                      ),
                      const SizedBox(height: 20),
                      Image.asset(
                        AppImages.loginAsset,
                        height: 340,
                      ),
                      Container(
                        height: height / 2.5,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(26),
                            topRight: Radius.circular(26),
                          ),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormField(
                                controller: _otpController,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                                maxLength: 6,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.whiteColor,
                                  errorStyle: const TextStyle(
                                    color: AppColors.darkYellowColor,
                                  ),
                                  hintText: 'Enter OTP',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter 6 digit OTP to continue.';
                                  }
                                  if (value.length < 6) {
                                    return 'OTP is not valid. Please make sure you enter the 6 digit OTP.';
                                  }
                                },
                              ),
                              const SizedBox(height: 70),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    verifyOtpBloc.add(
                                      VerifyOtpLoadingEvent(
                                        widget.mobileNumber,
                                        _otpController.text.trim(),
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(width - 30, 45),
                                  backgroundColor: AppColors.buttonGoldenYellow,
                                  foregroundColor: AppColors.blackColor,
                                ),
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              case VerifyOtpLoadingState:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case VerifyOtpErrorState:
                final errorState = state as VerifyOtpErrorState;
                return Center(
                  child: Text(errorState.error),
                );
              default:
                return const Center(
                  child: Text('Error Verifying OTP.'),
                );
            }
          },
        ),
      ),
    );
  }
}
