import 'package:flutter/material.dart';

import 'constants.dart';
import 'custom_text.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String course;
  final String bio;

  const ProfileCard({
    super.key,
    required this.name,
    required this.course,
    required this.bio,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.cardWidth,
      padding: const EdgeInsets.all(AppSizes.cardPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        gradient: const LinearGradient(
          colors: [AppColors.darkBlue, AppColors.midBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            text: name,
            size: AppSizes.nameSize,
            weight: FontWeight.bold,
            color: AppColors.cream,
          ),
          const SizedBox(height: 8),
          CustomText(
            text: course,
            size: AppSizes.courseSize,
            color: AppColors.cream,
          ),
          const SizedBox(height: 15),
          CustomText(
            text: bio,
            size: AppSizes.bioSize,
            color: AppColors.cream,
            italic: true,
          ),
        ],
      ),
    );
  }
}
