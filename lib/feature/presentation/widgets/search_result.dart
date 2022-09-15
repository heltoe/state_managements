import 'package:flutter/material.dart';
import 'package:state_menagements/feature/domain/entities/person.dart';
import 'package:state_menagements/feature/presentation/widgets/person_cache_image.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({
    Key? key,
    required this.person,
  }) : super(key: key);
  final PersonEntity person;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PersonCacheImage(
            size: 300,
            width: double.maxFinite,
            url: person.image,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              person.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              person.location.name,
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
