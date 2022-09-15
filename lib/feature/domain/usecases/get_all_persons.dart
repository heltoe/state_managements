import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:state_menagements/core/error/failure.dart';
import 'package:state_menagements/core/usecases/usecase.dart';
import 'package:state_menagements/feature/domain/entities/person.dart';
import 'package:state_menagements/feature/domain/repository/person_repository.dart';

class GetAllPersons extends UseCase<List<PersonEntity>, PagePersonParams> {
  final PersonRepository personRepository;

  GetAllPersons({ required this.personRepository });

  Future<Either<Failure,List<PersonEntity>>> call(PagePersonParams params) async {
    return await personRepository.getAllPersons(params.page);
  }
}

class PagePersonParams extends Equatable {
  final int page;
  const PagePersonParams({ required this.page});

  @override
  List<Object?> get props => [page];
}