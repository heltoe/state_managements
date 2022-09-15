import 'package:state_menagements/feature/domain/entities/entity.dart';

class LocationModel extends LocationEntity {
  LocationModel({
    required super.name,
    required super.url,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json["name"],
      url: json["url"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "url": url,
    };
  }
}
