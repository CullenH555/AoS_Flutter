import 'package:get_it/get_it.dart';
import 'package:aos_playmat_builder_flutter/data/datasources/rule_source_remote_datasource.dart';
import 'package:aos_playmat_builder_flutter/blocs/selections/selections_bloc.dart';
import 'package:aos_playmat_builder_flutter/data/repositories/repository.dart';
import 'package:aos_playmat_builder_flutter/domain/usecases/gen_button_styler.dart';
import 'package:aos_playmat_builder_flutter/domain/usecases/gen_display.dart';
import 'package:aos_playmat_builder_flutter/domain/usecases/gen_next_page.dart';
import 'package:aos_playmat_builder_flutter/domain/usecases/gen_reset_to_start.dart';
import 'package:aos_playmat_builder_flutter/domain/usecases/gen_save_delete.dart';

final sl = GetIt.instance;

void init() {
  // Bloc
  sl.registerFactory(() => SelectionsBloc(repository: sl()));

  // Usecases
  sl.registerLazySingleton(() => GenButtonStyler());
  sl.registerLazySingleton(() => GenDisplay(repository: sl()));
  sl.registerLazySingleton(() => GenNextPage(repository: sl()));
  sl.registerLazySingleton(() => GenResetToStart(repository: sl()));
  sl.registerLazySingleton(() => GenNextSave(repository: sl()));

  // Repo
  sl.registerLazySingleton<RuleRepository>(
    () => RuleRepoImp(remoteDatasource: sl()),
  );

  // Datasource
  sl.registerLazySingleton<RuleSourceRemoteDatasource>(
      () => RuleSourceRemoteDatasourceImp());
}
