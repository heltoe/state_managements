import 'package:flutter/material.dart';
import 'package:state_menagements/feature/domain/entities/person.dart';
import 'package:state_menagements/feature/presentation/widgets/description_field.dart';
import 'package:state_menagements/feature/presentation/widgets/person_cache_image.dart';
import 'package:state_menagements/feature/presentation/widgets/status_dot.dart';

class DetailDataPerson {
  String title;
  String description;

  DetailDataPerson({required this.title, required this.description});
}

class PersonDetail extends StatelessWidget {
  const PersonDetail({
    Key? key,
    required this.person,
  }) : super(key: key);
  final PersonEntity person;

  @override
  Widget build(BuildContext context) {
    List<DetailDataPerson> listData = [
      DetailDataPerson(
        title: person.gender,
        description: "Gender",
      ),
      DetailDataPerson(
        title: person.episode.length.toString(),
        description: "Number of episodes",
      ),
      DetailDataPerson(
        title: person.species,
        description: "Species",
      ),
      DetailDataPerson(
        title: person.location.name,
        description: "Last known location",
      ),
      DetailDataPerson(
        title: person.origin.name,
        description: "Origin",
      ),
      DetailDataPerson(
        title: person.created.toIso8601String(),
        description: "Was created",
      ),
    ];
    if (person.type.isNotEmpty) {
      listData.add(DetailDataPerson(
        title: person.type,
        description: "Type",
      ));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Character")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Text(
              person.name,
              style: const TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            PersonCacheImage(size: 260, url: person.image),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StatusDot(
                  status: person.status,
                  size: 12,
                ),
                const SizedBox(width: 8),
                Text(
                  person.status,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            Column(
              children: List.generate(
                listData.length,
                (index) => DescriptionField(
                  description: listData[index].description,
                  title: listData[index].title,
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
