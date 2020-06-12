import 'package:date_bloc/features/date/data/data_sources/local_data_source.dart';
import 'package:date_bloc/features/date/data/repository/date_repository_impl.dart';
import 'package:date_bloc/features/date/domain/repository/date_repository.dart';
import 'package:date_bloc/features/date/presentation/bloc/date_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Feature - date
  // bloc
  sl.registerFactory(() => DateBloc(repo: sl()));

  sl.registerLazySingleton<DateRepository>(
    () => DateRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<DateLocalDataSource>(
      () => DateLocalDataSourceImpl(sl()));

  // external
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
}
