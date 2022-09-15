import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:state_menagements/common/config.dart';
import 'package:state_menagements/core/error/exception.dart';
import 'package:state_menagements/feature/data/models/person_model.dart';

abstract class PersonLocalDataSource {
  Future<List<PersonModel>> getLastPersonsFromCache();

  Future<void> personsToCache(List<PersonModel> persons);
}

class PersonLocalDataSourceImp implements PersonLocalDataSource {
  final SharedPreferences sharedPreferences;

  PersonLocalDataSourceImp({required this.sharedPreferences});

  @override
  Future<List<PersonModel>> getLastPersonsFromCache() {
    final jsonPersonsList = sharedPreferences
        .getStringList(BaseConfig.nameListPersonsInSharedPreference);
    if (jsonPersonsList != null && jsonPersonsList.isNotEmpty) {
      return Future.value(jsonPersonsList
          .map((person) => PersonModel.fromJson(jsonDecode(person)))
          .toList());
    }
    throw CacheException();
  }

  @override
  Future<void> personsToCache(List<PersonModel> persons) {
    final List<String> jsonPersonsList =
        persons.map((person) => jsonEncode(person.toJson())).toList();

    sharedPreferences.setStringList(
        BaseConfig.nameListPersonsInSharedPreference, jsonPersonsList);
    return Future.value(jsonPersonsList);
  }
}
