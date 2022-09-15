import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_menagements/feature/domain/entities/person.dart';
import 'package:state_menagements/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:state_menagements/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:state_menagements/feature/presentation/bloc/search_bloc/search_state.dart';
import 'package:state_menagements/feature/presentation/pages/person_detail.dart';
import 'package:state_menagements/feature/presentation/widgets/search_result.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate() : super(searchFieldLabel: 'Search for characters...');

  final _suggestions = [
    "Rick",
    "Morty",
    "Beth",
    "Jerry",
    "Summer",
  ];

  Widget _showErrorText(String message) {
    return Container(
      color: Colors.black,
      child: Text(
        message,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back_outlined),
      tooltip: "Back",
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    BlocProvider.of<PersonSearchBloc>(context, listen: false)
        .add(SearchPersons(personQuery: query));
    return BlocBuilder<PersonSearchBloc, PersonSearchState>(
        builder: (context, state) {
      if (state is PersonSearchLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is PersonSearchLoaded) {
        final personList = state.persons;
        if (personList.isEmpty) {
          return _showErrorText('No Characters with that name found');
        }
        return ListView.builder(
          itemCount: personList.length,
          itemBuilder: (context, index) {
            PersonEntity person = personList[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PersonDetail(person: person)),
                );
              },
              child: SearchResult(person: person),
            );
          },
        );
      } else if (state is PersonSearchError) {
        return _showErrorText(state.message);
      } else {
        return const Center(child: Icon(Icons.now_wallpaper));
      }
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return Container();
    }
    return ListView.separated(
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) => Text(
              _suggestions[index],
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: _suggestions.length);
  }
}
