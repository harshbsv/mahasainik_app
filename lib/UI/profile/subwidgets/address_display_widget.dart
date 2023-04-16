import 'package:flutter/material.dart';
import 'package:mahasainik_app/UI/profile/add_address.dart';
import 'package:mahasainik_app/utils/color_assets.dart';

class AddressDisplayWidget extends StatefulWidget {
  const AddressDisplayWidget({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  final AsyncSnapshot snapshot;

  @override
  State<AddressDisplayWidget> createState() => _AddressDisplayWidgetState();
}

class _AddressDisplayWidgetState extends State<AddressDisplayWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.snapshot.data!.address.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColors.primaryColor,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Place Name :',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.snapshot.data!.address[index].placeName ?? "",
                    style: const TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Full Name :',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.snapshot.data!.address[index].title ?? "",
                    style: const TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.snapshot.data!.address[index].firstName ?? "",
                    style: const TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.snapshot.data!.address[index].lastName ?? "",
                    style: const TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Address Line 1 :',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.snapshot.data!.address[index].line1 ?? "",
                    style: const TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Address Line 2 :',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.snapshot.data!.address[index].line2 ?? "",
                    style: const TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Address Line 3 :',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.snapshot.data!.address[index].line3 ?? "",
                    style: const TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Address Line 4 :',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.snapshot.data!.address[index].line4 ?? "",
                    style: const TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'State :',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.snapshot.data!.address[index].state ?? "",
                    style: const TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Postcode :',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.snapshot.data!.address[index].postcode ?? "",
                    style: const TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Mobile Number :',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.snapshot.data!.address[index].phoneNumber ?? "",
                    style: const TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddAddresses(
                            pageTitle: 'Edit Address',
                            id: widget.snapshot.data!.address[index].id,
                            placeName:
                                widget.snapshot.data!.address[index].placeName,
                            title: widget.snapshot.data!.address[index].title,
                            firstName:
                                widget.snapshot.data!.address[index].firstName,
                            lastName:
                                widget.snapshot.data!.address[index].lastName,
                            line1: widget.snapshot.data!.address[index].line1,
                            line2: widget.snapshot.data!.address[index].line2,
                            line3: widget.snapshot.data!.address[index].line3,
                            line4: widget.snapshot.data!.address[index].line4,
                            state: widget.snapshot.data!.address[index].state,
                            postcode:
                                widget.snapshot.data!.address[index].postcode,
                            phoneNumber: widget
                                .snapshot.data!.address[index].phoneNumber,
                            notes: widget.snapshot.data!.address[index].notes,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Edit Address',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
