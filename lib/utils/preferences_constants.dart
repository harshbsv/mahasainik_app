import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

String kLoginToken = 'loginToken';
String kStoreId = 'storeId';
String kUserLoginStatus = 'userLoginStatus';
String kUserLat = 'userLatitude';
String kUserLong = 'userLongitude';
String kUserCurrentAddress = 'userCurrentAddress';
String kNearbyStoreId = 'nearbyStoreId';

class SharedUtils {
  Logger logger = Logger();
  bool? userLoginStatus = false;
  String? userAddress = '';

  fetchLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    userLoginStatus = prefs.getBool(kUserLoginStatus);
    logger.i('User Login Status from Splash: $userLoginStatus');
  }

  fetchUserAddress() async {
    final prefs = await SharedPreferences.getInstance();
    userAddress = prefs.getString(kUserCurrentAddress);
    logger.i('User Address from Splash: $userAddress');
  }
  
}
