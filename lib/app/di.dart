import 'package:dio/dio.dart';
import 'package:first_project_advanced/app/app_prefs.dart';
import 'package:first_project_advanced/data/data_source/remote_data_source.dart';
import 'package:first_project_advanced/data/network/app_api.dart';
import 'package:first_project_advanced/data/network/dio_factory.dart';
import 'package:first_project_advanced/data/network/network_info.dart';
import 'package:first_project_advanced/data/repository/repository_impl.dart';
import 'package:first_project_advanced/domain/repository/repository.dart';
import 'package:first_project_advanced/domain/usecase/login_use_case.dart';
import 'package:first_project_advanced/pressentaion/login/viewmodel/login_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
// app module , its a module where we put all generic dependencies

// share prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(
    () => sharedPrefs,
  );

  // app prefs instance
  instance.registerLazySingleton<AppPreferences>(
    () => AppPreferences(instance<SharedPreferences>()),
  );

  //network info instance
  instance.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      InternetConnectionChecker(),
    ),
  );

  // dio factory instance
  instance.registerLazySingleton(
    () => DioFactory(instance()),
  );

  Dio dio = await instance<DioFactory>().getDio();

  // app service clinet instance
  instance.registerLazySingleton<AppServicesClient>(
    () => AppServicesClient(dio),
  );

  // remote data source instance
  instance.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourseImpl(instance()),
  );

// repository instance
  instance.registerLazySingleton<Repository>(
    () => RepositoryImpl(
      instance(),
      instance(),
    ),
  );
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginViewModel>(
      () => LoginViewModel(instance()),
    );

    instance.registerFactory<LoginUseCase>(
      () => LoginUseCase(instance()),
    );
  }
}
