import 'package:equatable/equatable.dart';
import 'package:state_menagements/feature/domain/entities/person.dart';

abstract class PersonSearchState extends Equatable {
  const PersonSearchState();

  @override
  List<Object> get props => [];
}

class PersonEmpty extends PersonSearchState {}
class PersonSearchLoading extends PersonSearchState {}
class PersonSearchLoaded extends PersonSearchState {
  final List<PersonEntity> persons;
  const PersonSearchLoaded({ required this.persons });
}
class PersonSearchError extends PersonSearchState {
  final String message;
  const PersonSearchError({ required this.message });

  @override
  List<Object> get props => [message];
}
