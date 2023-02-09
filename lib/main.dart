import 'package:flutter/material.dart';
import 'package:mahasainik_app/UI/home/home_page.dart';
import 'package:mahasainik_app/utils/color_assets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mahasainik',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.primaryColor,
        ),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: AppColors.whiteColor,
              displayColor: AppColors.whiteColor,
            ),
      ),
      home: const HomePage(),
    );
  }
}
