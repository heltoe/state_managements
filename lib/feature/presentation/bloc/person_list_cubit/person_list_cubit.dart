import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_menagements/core/error/failure.dart';
import 'package:state_menagements/feature/domain/entities/person.dart';
import 'package:state_menagements/feature/domain/usecases/get_all_persons.dart';
import 'package:state_menagements/feature/presentation/bloc/person_list_cubit/person_list_state.dart';

class PersonListCubit extends Cubit<PersonListState> {
  final GetAllPersons getAllPersons;

  PersonListCubit({required this.getAllPersons}) : super(PersonListEmpty());

  int page = 1;

  void loadPerson() async {
    if (state is PersonListLoading) return;

    final currentState = state;

    var oldPerson = <PersonEntity>[];
    if (currentState is PersonListLoaded) {
      oldPerson = currentState.personsList;
    }
    emit(PersonListLoading(oldPersonList: oldPerson, isFirstFetch: page == 1));
    final failureOrPerson = await getAllPersons(PagePersonParams(page: page));
    failureOrPerson.fold(
      (error) => emit(PersonListError(message: _mapFailureToMessage(error))),
      (result) {
        page++;
        final persons = (state as PersonListLoading).oldPersonList;
        persons.addAll(result);
        emit(PersonListLoaded(personsList: persons));
      },
    );
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
