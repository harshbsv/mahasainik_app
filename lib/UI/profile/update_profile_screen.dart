import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mahasainik_app/networking/api_endpoints.dart';
import 'package:mahasainik_app/utils/color_assets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({
    Key? key,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.profile_photo,
  }) : super(key: key);

  final String? first_name, last_name, email;
  final String? profile_photo;

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final GlobalKey<FormState> _updateUserFormKey = GlobalKey<FormState>();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  Map<String, String> formData = <String, String>{};
  File pickedImage = File('');
  bool isPicked = false;
  late SharedPreferences sharedPreferences;
  late final ImagePicker _picker;
  late String? token;

  _getImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage = File(image.path);
      setState(() {
        isPicked = true;
      });
    }
  }

  Future<void> putUserProfile(
    String firstName,
    String lastName,
    String email,
    String profilePhoto,
  ) async {
    try {
      final tokenPref = await SharedPreferences.getInstance();
      String? token = tokenPref.getString('token');
      print('tokenpref: $token');

      var request =
          http.MultipartRequest('PUT', Uri.parse(ApiEndpoints.updateProfile));

      request.headers['Authorization'] = 'Token $token';
      request.fields['first_name'] = firstName;
      request.fields['last_name'] = lastName;
      request.fields['email'] = email;
      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          await File.fromUri(Uri.parse(profilePhoto)).readAsBytes(),
        ),
      );

      request.send().then((result) {
        http.Response.fromStream(result).then((response) {
          print('response code: ${response.statusCode}');
          if (response.statusCode == 200) {
            // final updateProfile = UpdateUserProfile.fromJson(
            //     jsonDecode(response.body));
            print('updateProfile: ${response.body}');
            Fluttertoast.showToast(
              msg: response.body,
              toastLength: Toast.LENGTH_LONG,
            );
            //return updateProfile;
          } else {
            print('response status code: ${response.statusCode}');
            throw 'response failed';
          }
        });
      });
    } catch (e) {
      throw 'Error making request: $e';
    }
  }

  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();
    _firstNameController.text = widget.first_name!;
    _lastNameController.text = widget.last_name!;
    _emailController.text = widget.email!;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _updateUserFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        _getImageFromGallery();
                      },
                      child: isPicked
                          ? CircleAvatar(
                              backgroundColor: AppColors.primaryColor,
                              radius: 60,
                              child: Image.file(
                                pickedImage,
                                fit: BoxFit.fill,
                              ),
                            )
                          : const CircleAvatar(
                              backgroundColor: AppColors.primaryColor,
                              radius: 60,
                              child: Icon(
                                Icons.person,
                                size: 45,
                              ),
                            ),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  'First name:',
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'First Name',
                  ),
                  style: const TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Last name:',
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Last Name',
                  ),
                  style: const TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
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
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                  ),
                  style: const TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      putUserProfile(
                        _firstNameController.text.trim(),
                        _lastNameController.text.trim(),
                        _emailController.text.trim(),
                        pickedImage.path.toString() ?? '',
                      ).then((value) {
                        Navigator.of(context).pop();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 70,
                        vertical: 14,
                      ),
                      child: Text(
                        'Update Profile',
                        style: TextStyle(
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
