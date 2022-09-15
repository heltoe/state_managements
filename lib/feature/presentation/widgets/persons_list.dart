import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_menagements/feature/domain/entities/person.dart';
import 'package:state_menagements/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:state_menagements/feature/presentation/bloc/person_list_cubit/person_list_state.dart';
import 'package:state_menagements/feature/presentation/pages/person_detail.dart';
import 'package:state_menagements/feature/presentation/widgets/person_card.dart';

class PersonsList extends StatelessWidget {
  PersonsList({Key? key}) : super(key: key);

  final scrollController = ScrollController();

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge &&
          scrollController.position.pixels != 0) {
        context.read<PersonListCubit>().loadPerson();
      }
    });
  }

  _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);

    return BlocBuilder<PersonListCubit, PersonListState>(
      builder: (context, state) {
        List<PersonEntity> persons = [];
        bool isLoadingMore = false;

        if (state is PersonListLoading && state.isFirstFetch) {
          return _loadingIndicator();
        } else if (state is PersonListLoading) {
          persons = state.oldPersonList;
          isLoadingMore = true;
        } else if (state is PersonListLoaded) {
          persons = state.personsList;
        } else if (state is PersonListError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          );
        }
        return ListView.separated(
          controller: scrollController,
          itemBuilder: (context, index) {
            if (index < persons.length) {
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PersonDetail(person: persons[index])),
                    );
                  },
                  child: PersonCard(
                    person: persons[index],
                  ));
            }
            Timer(const Duration(milliseconds: 30), () {
              scrollController
                  .jumpTo(scrollController.position.maxScrollExtent);
            });
            return _loadingIndicator();
          },
          separatorBuilder: (context, index) {
            return Divider(color: Colors.grey[400]);
          },
          itemCount: persons.length + (isLoadingMore ? 1 : 0),
        );
      },
    );
  }
}
