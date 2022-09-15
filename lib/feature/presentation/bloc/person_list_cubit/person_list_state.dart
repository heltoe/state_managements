import 'package:equatable/equatable.dart';
import 'package:state_menagements/feature/domain/entities/person.dart';

abstract class PersonListState extends Equatable {
  const PersonListState();

  @override
  List<Object> get props => [];
}

class PersonListEmpty extends PersonListState {
  @override
  List<Object> get props => [];
}

class PersonListLoading extends PersonListState {
  final List<PersonEntity> oldPersonList;
  final bool isFirstFetch;
  const PersonListLoading({
    required this.oldPersonList,
    this.isFirstFetch = false,
  });

  @override
  List<Object> get props => [oldPersonList];
}

class PersonListLoaded extends PersonListState {
  final List<PersonEntity> personsList;
  const PersonListLoaded({ required this.personsList });

  @override
  List<Object> get props => [personsList];
}

class PersonListError extends PersonListState {
  final String message;
  const PersonListError({ required this.message });

  @override
  List<Object> get props => [message];
}
