import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mahasainik_app/networking/api_endpoints.dart';
import 'package:mahasainik_app/networking/trial_models/get_profile_model.dart';
import 'package:mahasainik_app/networking/trial_models/update_profile_model.dart';
import 'package:mahasainik_app/utils/color_assets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _updateUserFormKey = GlobalKey<FormState>();
  int addressFieldCount = 1;
  late String? token;
  Future<GetUserProfile>? _getUserProfileFuture;
  Future<UpdateUserProfile>? _updateUserProfile;

  Future<GetUserProfile> getUserProfile() async {
    try {
      final tokenPref = await SharedPreferences.getInstance();
      token = tokenPref.getString('token');
      print('tokenpref: $token');
      final response =
          await http.get(Uri.parse(ApiEndpoints.getProfile), headers: {
        'token': 'Token $token',
      });
      if (response.statusCode == 200) {
        final userProfile = GetUserProfile.fromJson(jsonDecode(response.body));
        print('Get User Profile: $userProfile');
        return userProfile;
      } else {
        throw 'status code other than 200';
      }
    } catch (e) {
      throw 'Exception fetching user profile.';
    }
  }

  //Future<UpdateUserProfile> updateUserProfile() async {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserProfileFuture = getUserProfile();
    //_updateUserProfile = updateUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _createNewAddressfield = List.generate(
      addressFieldCount,
      (int i) => const Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: TextField(
          maxLines: 5,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                key: _updateUserFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'My Account',
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Name:',
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      maxLines: 1,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Email:',
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      maxLines: 1,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Mobile:',
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      maxLines: 1,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                ),
                child: const Text(
                  'Update Profile',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(
                color: AppColors.greyColor,
              ),
              const SizedBox(height: 30),
              const Text(
                'Addresses:',
                style: TextStyle(color: AppColors.blackColor),
              ),
              const SizedBox(height: 20),
              ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                children: _createNewAddressfield,
              ),
              const SizedBox(height: 30),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                ),
                child: const Text(
                  'Add Address',
                  style: TextStyle(
                    color: AppColors.whiteColor,
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
