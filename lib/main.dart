import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mahasainik_app/UI/splashscreen/splash_screen.dart';
import 'package:mahasainik_app/bloc/login/login_bloc.dart';
import 'package:mahasainik_app/utils/color_assets.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  getDevicePosition();
  runApp(const MyApp());
}

Future<Position> getDevicePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  Position position;
  SharedPreferences preferences;
  preferences = await SharedPreferences.getInstance();
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best);
  print(
      'Device Position: ${position.latitude.toString()}, ${position.longitude.toString()}');
  preferences.setString('device_latitude', position.latitude.toString());
  preferences.setString('device_longitude', position.longitude.toString());
  return position;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(),
        ),
      ],
      child: MaterialApp(
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
        home: const SplashScreen(),
      ),
    );
  }
}
