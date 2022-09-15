import 'package:dartz/dartz.dart';
import 'package:state_menagements/core/error/failure.dart';
import 'package:state_menagements/feature/domain/entities/person.dart';

abstract class PersonRepository {
  Future<Either<Failure,List<PersonEntity>>> getAllPersons(int page);
  Future<Either<Failure,List<PersonEntity>>> searchPerson(String query);
}
