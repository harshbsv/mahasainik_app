import 'package:flutter/material.dart';
import 'package:mahasainik_app/utils/color_assets.dart';
import 'package:mahasainik_app/utils/image_assets.dart';

class HomeScreenFooter extends StatelessWidget {
  const HomeScreenFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Spacer(),
            SizedBox(
              height: 80,
              child: Image.asset(
                AppImages.mahasainikLogoSmall,
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'All Copyrights Reserved',
          style: TextStyle(
            color: AppColors.blackColor,
          ),
        ),
      ],
    );
  }
}
