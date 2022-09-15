import 'package:state_menagements/core/error/failure.dart';
import 'package:state_menagements/feature/domain/usecases/search_person.dart';
import 'package:state_menagements/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:state_menagements/feature/presentation/bloc/search_bloc/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchPerson searchPersons;

  PersonSearchBloc({required this.searchPersons}) : super(PersonEmpty()) {
    on<SearchPersons>((event, emit) async {
      emit(PersonSearchLoading());
      final failureOrPerson = await searchPersons(SearchPersonParams(query: event.personQuery));
      emit(failureOrPerson.fold(
        (failure) => PersonSearchError(message: _mapFailureToMessage(failure)),
        (person) => PersonSearchLoaded(persons: person),
      ));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "Server Failure";
      case CacheFailure:
        return "Cache Failure";
      default:
        return "Unexpected Error";
    }
  }
}
