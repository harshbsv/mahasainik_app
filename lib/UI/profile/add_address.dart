import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mahasainik_app/networking/api_endpoints.dart';
import 'package:mahasainik_app/networking/trial_models/add_address_model.dart';
import 'package:mahasainik_app/networking/trial_models/update_address_model.dart';
import 'package:mahasainik_app/utils/color_assets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAddresses extends StatefulWidget {
  const AddAddresses({
    Key? key,
    required this.pageTitle,
    this.id,
    this.placeName,
    this.title,
    this.firstName,
    this.lastName,
    this.line1,
    this.line2,
    this.line3,
    this.line4,
    this.city,
    this.state,
    this.postcode,
    this.phoneNumber,
    this.notes,
  }) : super(key: key);

  final int? id;

  final String? placeName,
      title,
      firstName,
      lastName,
      line1,
      line2,
      line3,
      line4,
      city,
      state,
      postcode,
      phoneNumber,
      notes;

  final String pageTitle;

  @override
  State<AddAddresses> createState() => _AddAddressesState();
}

class _AddAddressesState extends State<AddAddresses> {
  late TextEditingController placeName,
      title,
      firstName,
      lastName,
      line1,
      line2,
      line3,
      line4,
      city,
      state,
      postcode,
      phoneNumber,
      notes;

  Future<AddAddressModel> addUserAddress(
    String placeName,
    String title,
    String firstName,
    String lastName,
    String line1,
    String line2,
    String line3,
    String line4,
    String city,
    String state,
    String postcode,
    String phoneNumber,
    String notes,
  ) async {
    try {
      final tokenPref = await SharedPreferences.getInstance();
      String? token = tokenPref.getString('token');
      print('tokenpref: $token');
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.userAddresses),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token',
        },
        body: jsonEncode(<String, String>{
          "place_name": placeName,
          "title": title,
          "first_name": firstName,
          "last_name": lastName,
          "line1": line1,
          "line2": line2,
          "line3": line3,
          "line4": line4,
          "city": city,
          "state": state,
          "postcode": postcode,
          "phone_number": phoneNumber,
          "notes": notes,
        }),
      );
      if (response.statusCode == 200) {
        final addAddress = AddAddressModel.fromJson(jsonDecode(response.body));
        print('OTP: ${addAddress}');
        Fluttertoast.showToast(
          msg: addAddress.message,
          toastLength: Toast.LENGTH_LONG,
        );
        return addAddress;
      } else {
        throw 'Error making request';
      }
    } catch (e) {
      throw 'Error making request';
    }
  }

  Future<UpdateAddressModel> updateUserAddress(
    int id,
    String placeName,
    String title,
    String firstName,
    String lastName,
    String line1,
    String line2,
    String line3,
    String line4,
    String city,
    String state,
    String postcode,
    String phoneNumber,
    String notes,
  ) async {
    try {
      final tokenPref = await SharedPreferences.getInstance();
      String? token = tokenPref.getString('token');
      print('tokenpref: $token');
      http.Response response = await http.put(
        Uri.parse('${ApiEndpoints.userAddresses}$id/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token',
        },
        body: jsonEncode(<String, String>{
          "place_name": placeName,
          "title": title,
          "first_name": firstName,
          "last_name": lastName,
          "line1": line1,
          "line2": line2,
          "line3": line3,
          "line4": line4,
          "city": city,
          "state": state,
          "postcode": postcode,
          "phone_number": phoneNumber,
          "notes": notes,
        }),
      );
      if (response.statusCode == 200) {
        final updateAddress =
            UpdateAddressModel.fromJson(jsonDecode(response.body));
        print('OTP: ${updateAddress}');
        Fluttertoast.showToast(
          msg: updateAddress.message,
          toastLength: Toast.LENGTH_LONG,
        );
        return updateAddress;
      } else {
        throw 'Error making request';
      }
    } catch (e) {
      throw 'Error making request';
    }
  }

  void _isPathEditAddress() {
    if (widget.pageTitle == 'Edit Address') {
      print('edit path');
      placeName = TextEditingController(text: widget.placeName);
      title = TextEditingController(text: widget.title);
      firstName = TextEditingController(text: widget.firstName);
      lastName = TextEditingController(text: widget.lastName);
      line1 = TextEditingController(text: widget.line1);
      line2 = TextEditingController(text: widget.line2);
      line3 = TextEditingController(text: widget.line3);
      line4 = TextEditingController(text: widget.line4);
      city = TextEditingController(text: widget.city);
      state = TextEditingController(text: widget.state);
      postcode = TextEditingController(text: widget.postcode);
      phoneNumber = TextEditingController(text: widget.phoneNumber);
      notes = TextEditingController(text: widget.notes);
    } else {
      print('add path');
      placeName = TextEditingController();
      title = TextEditingController();
      firstName = TextEditingController();
      lastName = TextEditingController();
      line1 = TextEditingController();
      line2 = TextEditingController();
      line3 = TextEditingController();
      line4 = TextEditingController();
      city = TextEditingController();
      state = TextEditingController();
      postcode = TextEditingController();
      phoneNumber = TextEditingController();
      notes = TextEditingController();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isPathEditAddress();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    placeName.dispose();
    title.dispose();
    firstName.dispose();
    lastName.dispose();
    line1.dispose();
    line2.dispose();
    line3.dispose();
    line4.dispose();
    city.dispose();
    state.dispose();
    postcode.dispose();
    phoneNumber.dispose();
    notes.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageTitle),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Place Name :',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: placeName,
                cursorHeight: 24,
                style: const TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Full Name :',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(
                    width: 60,
                    child: TextField(
                      controller: title,
                      cursorHeight: 24,
                      style: const TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: firstName,
                      cursorHeight: 24,
                      style: const TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: lastName,
                      cursorHeight: 24,
                      style: const TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Address Line 1 :',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: line1,
                cursorHeight: 24,
                style: const TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Address Line 2 :',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: line2,
                cursorHeight: 24,
                style: const TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Address Line 3 :',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: line3,
                cursorHeight: 24,
                style: const TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Address Line 4 :',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: line4,
                cursorHeight: 24,
                style: const TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'City :',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: city,
                cursorHeight: 24,
                style: const TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'State :',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: state,
                cursorHeight: 24,
                style: const TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Post Code :',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: postcode,
                cursorHeight: 24,
                style: const TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 16,
                ),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Phone Number :',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: phoneNumber,
                cursorHeight: 24,
                style: const TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 16,
                ),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Notes :',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: notes,
                cursorHeight: 24,
                style: const TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 16,
                ),
                maxLines: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (widget.pageTitle == 'Edit Address') {
                      updateUserAddress(
                        widget.id!,
                        placeName.text.trim(),
                        title.text.trim(),
                        firstName.text.trim(),
                        lastName.text.trim(),
                        line1.text.trim(),
                        line2.text.trim(),
                        line3.text.trim(),
                        line4.text.trim(),
                        city.text.trim(),
                        state.text.trim(),
                        postcode.text.trim(),
                        phoneNumber.text.trim(),
                        notes.text.trim(),
                      ).then((value) {
                        Navigator.of(context).pop();
                      });
                    } else {
                      addUserAddress(
                        placeName.text.trim(),
                        title.text.trim(),
                        firstName.text.trim(),
                        lastName.text.trim(),
                        line1.text.trim(),
                        line2.text.trim(),
                        line3.text.trim(),
                        line4.text.trim(),
                        city.text.trim(),
                        state.text.trim(),
                        postcode.text.trim(),
                        phoneNumber.text.trim(),
                        notes.text.trim(),
                      ).then((value) {
                        Navigator.of(context).pop();
                      });
                    }
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
                      'Save Address',
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
