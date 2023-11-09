import 'package:flutter/material.dart';
import 'package:mahasainik_app/UI/splashscreen/splash_screen.dart';
import 'package:mahasainik_app/utils/color_assets.dart';
import 'package:mahasainik_app/utils/common_utils.dart';
import 'package:mahasainik_app/utils/device_position_fetch.dart';
import 'package:mahasainik_app/utils/providers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  getDevicePosition();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: MaterialApp(
        title: kAppName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: AppColors.primaryColor,
          ),
          // useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
