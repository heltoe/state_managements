import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:state_menagements/core/error/failure.dart';
import 'package:state_menagements/core/usecases/usecase.dart';
import 'package:state_menagements/feature/domain/entities/person.dart';
import 'package:state_menagements/feature/domain/repository/person_repository.dart';

class SearchPerson extends UseCase<List<PersonEntity>, SearchPersonParams> {
  final PersonRepository personRepository;

  SearchPerson({ required this.personRepository });

  Future<Either<Failure,List<PersonEntity>>> call(SearchPersonParams searchPersonParams) async {
    return await personRepository.searchPerson(searchPersonParams.query);
  }
}

class SearchPersonParams extends Equatable {
  final String query;
  const SearchPersonParams({ required this.query });

  @override
  List<Object?> get props => [query];
}