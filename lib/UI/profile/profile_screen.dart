import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahasainik_app/UI/profile/add_address.dart';
import 'package:mahasainik_app/UI/profile/subwidgets/address_display_widget.dart';
import 'package:mahasainik_app/UI/profile/update_profile_screen.dart';
import 'package:mahasainik_app/bloc/profile/profile_bloc.dart';
import 'package:mahasainik_app/utils/color_assets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileBloc profileBloc = ProfileBloc();
  // late String? token;
  // Future<GetUserProfile>? _getUserProfileFuture;

  // Future<GetUserProfile> getUserProfile() async {
  //   try {
  //     final tokenPref = await SharedPreferences.getInstance();
  //     token = tokenPref.getString(kLoginToken);
  //     print('tokenpref: $token');
  //     final response =
  //         await http.get(Uri.parse(ApiEndpoints.getProfile), headers: {
  //       'Authorization': 'Token $token',
  //     });
  //     print('response : ${response.body.toString()}');
  //     if (response.statusCode == 200) {
  //       final userProfile = GetUserProfile.fromJson(jsonDecode(response.body));
  //       print('userprofile email: ${userProfile.email}');
  //       tokenPref.setString('user_email', userProfile.email);
  //       tokenPref.setString('first_name', userProfile.firstName);
  //       tokenPref.setString('last_name', userProfile.lastName);
  //       tokenPref.setString('line1', userProfile.address[0].line1);
  //       tokenPref.setString('line2', userProfile.address[0].line2);
  //       tokenPref.setString('line3', userProfile.address[0].line3);
  //       tokenPref.setString('line4', userProfile.address[0].line4);
  //       tokenPref.setString('notes', userProfile.address[0].notes);
  //       tokenPref.setString('phone_number', userProfile.address[0].phoneNumber);
  //       tokenPref.setString('postcode', userProfile.address[0].postcode);
  //       tokenPref.setString('state', userProfile.address[0].state);
  //       tokenPref.setString('title', userProfile.address[0].title);
  //       return userProfile;
  //     } else {
  //       throw 'status code other than 200';
  //     }
  //   } catch (e) {
  //     throw 'Exception fetching user profile.';
  //   }
  // }

  //Future<UpdateUserProfile> updateUserProfile() async {}

  @override
  void initState() {
    super.initState();
    profileBloc.add(ProfileLoadingEvent());
    // _getUserProfileFuture = getUserProfile();
    //_updateUserProfile = updateUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

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
              const Text(
                'My Account',
                style: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              BlocBuilder<ProfileBloc, ProfileState>(
                bloc: profileBloc,
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case ProfileLoadingState:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    // case ProfileInitialState:
                    case ProfileSuccessState:
                      final successState = state as ProfileSuccessState;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Spacer(),
                              CircleAvatar(
                                backgroundColor: AppColors.primaryColor,
                                radius: 60,
                                child: Image.network(
                                  successState
                                      .userProfileResponseModel.profile_photo,
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
                          Container(
                            width: width,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              successState.userProfileResponseModel.first_name,
                              style: const TextStyle(
                                color: AppColors.blackColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
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
                          Container(
                            width: width,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              successState.userProfileResponseModel.last_name,
                              style: const TextStyle(
                                color: AppColors.blackColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
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
                          Container(
                            width: width,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              successState.userProfileResponseModel.email,
                              style: const TextStyle(
                                color: AppColors.blackColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Phone Number:',
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: width,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              successState.userProfileResponseModel.phone_no
                                  .toString(),
                              style: const TextStyle(
                                color: AppColors.blackColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => UpdateProfileScreen(
                                      first_name: successState
                                          .userProfileResponseModel.first_name,
                                      last_name: successState
                                          .userProfileResponseModel.last_name,
                                      email: successState
                                          .userProfileResponseModel.email,
                                      profile_photo: successState
                                          .userProfileResponseModel
                                          .profile_photo,
                                    ),
                                  ),
                                );
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
                                  'Edit Profile',
                                  style: TextStyle(
                                    color: AppColors.whiteColor,
                                  ),
                                ),
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
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          AddressDisplayWidget(
                            responseModel:
                                successState.userProfileResponseModel,
                          ),
                        ],
                      );
                    case ProfileErrorState:
                    default:
                      return const Center(
                        child: Text('Error loading user profile.'),
                      );
                  }
                },
              ),
              // FutureBuilder<GetUserProfile>(
              //   future: _getUserProfileFuture,
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {
              //       print('Snapshot Profile : ${snapshot.data}');
              //       return Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Row(
              //             children: [
              //               const Spacer(),
              //               CircleAvatar(
              //                 backgroundColor: AppColors.primaryColor,
              //                 radius: 60,
              //                 child: Image.network(
              //                   snapshot.data!.profilePhoto,
              //                 ),
              //               ),
              //               const Spacer(),
              //             ],
              //           ),
              //           const SizedBox(height: 30),
              //           const Text(
              //             'First name:',
              //             style: TextStyle(
              //               color: AppColors.blackColor,
              //               fontSize: 17,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //           const SizedBox(height: 10),
              //           Container(
              //             width: width,
              //             padding: const EdgeInsets.symmetric(
              //               horizontal: 14,
              //               vertical: 10,
              //             ),
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(12),
              //               border: Border.all(
              //                 color: AppColors.primaryColor,
              //                 width: 1,
              //               ),
              //             ),
              //             child: Text(
              //               snapshot.data!.firstName,
              //               style: const TextStyle(
              //                 color: AppColors.blackColor,
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //           ),
              //           const SizedBox(height: 20),
              //           const Text(
              //             'Last name:',
              //             style: TextStyle(
              //               color: AppColors.blackColor,
              //               fontSize: 17,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //           const SizedBox(height: 10),
              //           Container(
              //             width: width,
              //             padding: const EdgeInsets.symmetric(
              //               horizontal: 14,
              //               vertical: 10,
              //             ),
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(12),
              //               border: Border.all(
              //                 color: AppColors.primaryColor,
              //                 width: 1,
              //               ),
              //             ),
              //             child: Text(
              //               snapshot.data!.lastName,
              //               style: const TextStyle(
              //                 color: AppColors.blackColor,
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //           ),
              //           const SizedBox(height: 20),
              //           const Text(
              //             'Email:',
              //             style: TextStyle(
              //               color: AppColors.blackColor,
              //               fontSize: 17,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //           const SizedBox(height: 10),
              //           Container(
              //             width: width,
              //             padding: const EdgeInsets.symmetric(
              //               horizontal: 14,
              //               vertical: 10,
              //             ),
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(12),
              //               border: Border.all(
              //                 color: AppColors.primaryColor,
              //                 width: 1,
              //               ),
              //             ),
              //             child: Text(
              //               snapshot.data!.email,
              //               style: const TextStyle(
              //                 color: AppColors.blackColor,
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //           ),
              //           const SizedBox(height: 20),
              //           const Text(
              //             'Phone Number:',
              //             style: TextStyle(
              //               color: AppColors.blackColor,
              //               fontSize: 17,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //           const SizedBox(height: 10),
              //           Container(
              //             width: width,
              //             padding: const EdgeInsets.symmetric(
              //               horizontal: 14,
              //               vertical: 10,
              //             ),
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(12),
              //               border: Border.all(
              //                 color: AppColors.primaryColor,
              //                 width: 1,
              //               ),
              //             ),
              //             child: Text(
              //               snapshot.data!.phoneNo.toString(),
              //               style: const TextStyle(
              //                 color: AppColors.blackColor,
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //           ),
              //           const SizedBox(height: 30),
              //           Center(
              //             child: ElevatedButton(
              //               onPressed: () {
              //                 Navigator.of(context).push(
              //                   MaterialPageRoute(
              //                     builder: (context) => UpdateProfileScreen(
              //                       first_name: snapshot.data!.firstName,
              //                       last_name: snapshot.data!.lastName,
              //                       email: snapshot.data!.email,
              //                       profile_photo: snapshot.data!.profilePhoto,
              //                     ),
              //                   ),
              //                 );
              //               },
              //               style: ElevatedButton.styleFrom(
              //                 backgroundColor: AppColors.primaryColor,
              //               ),
              //               child: const Padding(
              //                 padding: EdgeInsets.symmetric(
              //                   horizontal: 70,
              //                   vertical: 14,
              //                 ),
              //                 child: Text(
              //                   'Edit Profile',
              //                   style: TextStyle(
              //                     color: AppColors.whiteColor,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ),
              //           const SizedBox(height: 30),
              //           const Divider(
              //             color: AppColors.greyColor,
              //           ),
              //           const SizedBox(height: 30),
              //           const Text(
              //             'Addresses:',
              //             style: TextStyle(
              //               color: AppColors.blackColor,
              //               fontSize: 22,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //           const SizedBox(height: 20),
              //           AddressDisplayWidget(snapshot: snapshot),
              //         ],
              //       );
              //     }
              //     return const Center(
              //       child: CircularProgressIndicator(),
              //     );
              //   },
              // ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AddAddresses(
                          pageTitle: 'Add Address',
                        ),
                      ),
                    );
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
                      'Add Address',
                      style: TextStyle(
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
