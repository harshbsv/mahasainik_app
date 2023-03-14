import 'package:flutter/material.dart';
import 'package:mahasainik_app/UI/home/home_page.dart';
import 'package:mahasainik_app/UI/login/login_screen.dart';
import 'package:mahasainik_app/utils/navigation/enum_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case EnumRoute.home:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case EnumRoute.login:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Container(
            child: const Text('Nothing Here'),
          ),
        );
    }
  }
}
