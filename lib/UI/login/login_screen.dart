import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahasainik_app/UI/login/enter_otp_screen.dart';
import 'package:mahasainik_app/bloc/send_otp/login_bloc.dart';
import 'package:mahasainik_app/utils/color_assets.dart';
import 'package:mahasainik_app/utils/image_assets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _mobileController = TextEditingController();
  final LoginBloc loginBloc = LoginBloc();

  @override
  void initState() {
    super.initState();
    loginBloc.add(LoginInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
          child: BlocConsumer<LoginBloc, LoginState>(
        bloc: loginBloc,
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => OTPInputScreen(
                  mobileNumber: '+91${_mobileController.text}',
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case LoginInitialState:
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
                              controller: _mobileController,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                              maxLength: 10,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.whiteColor,
                                errorStyle: const TextStyle(
                                  color: AppColors.darkYellowColor,
                                ),
                                hintText: 'Enter 10-digit mobile number',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                // validateMobile(value!);
                                if (value == null || value.length < 10) {
                                  return 'Please enter a your valid mobile number.';
                                }
                              },
                            ),
                            const SizedBox(height: 70),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  loginBloc.add(
                                    LoginLoadingEvent(
                                      '+91${_mobileController.text.trim()}',
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
                                'Send OTP',
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
            case LoginLoadingState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case LoginErrorState:
              final errorState = state as LoginErrorState;
              return Center(
                child: Text(errorState.error),
              );
            default:
              return const Center(
                child: Text('Error Sending OTP.'),
              );
          }
        },
      )),
    );
  }
}
