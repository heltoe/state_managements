import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:state_menagements/core/platform/network_info.dart';
import 'package:state_menagements/feature/data/data_sources/person_local_data_source.dart';
import 'package:state_menagements/feature/data/data_sources/person_remote_data_source.dart';
import 'package:state_menagements/feature/data/repository/person_repository_impl.dart';
import 'package:state_menagements/feature/domain/repository/person_repository.dart';
import 'package:state_menagements/feature/domain/usecases/get_all_persons.dart';
import 'package:state_menagements/feature/domain/usecases/search_person.dart';
import 'package:state_menagements/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:state_menagements/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // bloc cubit
  sl.registerFactory(() => PersonListCubit(getAllPersons: sl()));
  sl.registerFactory(() => PersonSearchBloc(searchPersons: sl()));
  // UseCases
  sl.registerLazySingleton(() => GetAllPersons(personRepository: sl()));
  sl.registerLazySingleton(() => SearchPerson(personRepository: sl()));
  // Repository
  sl.registerLazySingleton<PersonRepository>(
    () => PersonRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<PersonRemoteDataSource>(() => PersonRemoteDataSourceImpl(client: http.Client()));
  sl.registerLazySingleton<PersonLocalDataSource>(() => PersonLocalDataSourceImp(sharedPreferences: sl()));
  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(internetConnectionChecker: sl()));
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingletonAsync(() async => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
