import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_menagements/common/app_colors.dart';
import 'package:state_menagements/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:state_menagements/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:state_menagements/locator_service.dart' as di;

import 'feature/presentation/pages/home_page.dart';
import 'locator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PersonListCubit>(create: (context) => sl<PersonListCubit>()..loadPerson()),
        BlocProvider<PersonSearchBloc>(create: (context) => sl<PersonSearchBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          backgroundColor: AppColors.mainBg,
          scaffoldBackgroundColor: AppColors.mainBg,
        ),
        home: const HomePage(),
      ),
    );
  }
}
