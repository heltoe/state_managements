import 'package:flutter/material.dart';
import 'package:state_menagements/common/app_colors.dart';

class DescriptionField extends StatelessWidget {
  const DescriptionField({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Text(
          description,
          style: const TextStyle(color: AppColors.greyColor),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
