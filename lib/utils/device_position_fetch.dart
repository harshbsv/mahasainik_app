import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:mahasainik_app/utils/preferences_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Position> getDevicePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  Position position;
  SharedPreferences preferences = await SharedPreferences.getInstance();
  Logger logger = Logger();
  String? currentAddress;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best);
  logger.i(
    'Device Position -> Lat: ${position.latitude.toString()}, Long: ${position.longitude.toString()}',
  );
  preferences.setString(kUserLat, position.latitude.toString());
  preferences.setString(kUserLong, position.longitude.toString());
  //turn the coordinates into a user readable address to display on home screen.
  await placemarkFromCoordinates(position.latitude, position.longitude)
      .then((List<Placemark> placemarks) {
    Placemark place = placemarks[0];
    currentAddress =
        '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
    preferences.setString(kUserCurrentAddress, currentAddress!);
    logger.i('Device Current User Address: $currentAddress');
  }).catchError((e) {
    logger.e('Device location error: $e');
  });
  return position;
}
