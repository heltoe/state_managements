import 'dart:convert';

import 'package:state_menagements/core/api_endpoints.dart';
import 'package:state_menagements/common/config.dart';
import 'package:state_menagements/core/error/exception.dart';
import 'package:state_menagements/feature/data/models/person_model.dart';
import 'package:http/http.dart' as http;

abstract class PersonRemoteDataSource {
  Future<List<PersonModel>> getAllPersons(int page);

  Future<List<PersonModel>> searchPersons(String query);
}

class PersonRemoteDataSourceImpl implements PersonRemoteDataSource {
  final http.Client client;
  PersonRemoteDataSourceImpl({required this.client});

  Future<List<PersonModel>> _getPersonFromUrl(String url) async {
    final response = await client.get(
      Uri.parse("${BaseConfig.baseUrl}${ApiEndpoints.characterUrl}$url"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      final persons = jsonDecode(response.body);
      return (persons["results"] as List)
          .map((person) => PersonModel.fromJson(person))
          .toList();
    }
    throw ServerException();
  }

  String _getStringFromMap(Map<String, dynamic> map) {
    return map.entries.map((entry) => "${entry.key}=${entry.value}").join("&");
  }

  String _getQueryString(Map<String, dynamic> map) {
    return "/?${_getStringFromMap(map)}";
  }

  @override
  Future<List<PersonModel>> getAllPersons(int page) =>
      _getPersonFromUrl(_getQueryString({"page": page}));

  @override
  Future<List<PersonModel>> searchPersons(String query) =>
      _getPersonFromUrl(_getQueryString({"name": query}));
}
