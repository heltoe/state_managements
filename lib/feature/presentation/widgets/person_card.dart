import 'package:flutter/material.dart';
import 'package:state_menagements/common/app_colors.dart';
import 'package:state_menagements/feature/domain/entities/person.dart';
import 'package:state_menagements/feature/presentation/widgets/person_cache_image.dart';
import 'package:state_menagements/feature/presentation/widgets/status_dot.dart';

class PersonCard extends StatelessWidget {
  const PersonCard({
    Key? key,
    required this.person,
  }) : super(key: key);
  final PersonEntity person;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cellBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            child: PersonCacheImage(
              size: 166,
              url: person.image,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Text(
                  person.name,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    StatusDot(status: person.status),
                    const SizedBox(width: 8),
                    Text(
                      "${person.status} - ${person.species}",
                      style: const TextStyle(color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  "Last known location:",
                  style: TextStyle(color: AppColors.greyColor),
                ),
                const SizedBox(height: 4),
                Text(
                  person.location.name,
                  style: const TextStyle(color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                const Text(
                  "Origin:",
                  style: TextStyle(color: AppColors.greyColor),
                ),
                const SizedBox(height: 4),
                Text(
                  person.origin.name,
                  style: const TextStyle(color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }
}
