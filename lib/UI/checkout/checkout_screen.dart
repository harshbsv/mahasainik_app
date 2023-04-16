import 'package:flutter/material.dart';
import 'package:mahasainik_app/UI/main_page/main_page.dart';
import 'package:mahasainik_app/networking/trial_models/checkout_model.dart';
import 'package:mahasainik_app/utils/color_assets.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({
    Key? key,
    required this.checkoutModel,
  }) : super(key: key);

  final CheckoutModel checkoutModel;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Bill Number :',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.checkoutModel.number,
                    style: const TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    'Bill Total :',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      widget.checkoutModel.totalInclTax,
                      style: const TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                widget.checkoutModel.toRawJson(),
                style: const TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MainPage(),
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
                      'Back to Home',
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
