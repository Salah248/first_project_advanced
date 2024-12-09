
import 'package:dio/dio.dart';
import 'package:first_project_advanced/app/app_prefs.dart';
import 'package:first_project_advanced/data/data_source/local_data_source.dart';
import 'package:first_project_advanced/data/data_source/remote_data_source.dart';
import 'package:first_project_advanced/data/network/app_api.dart';
import 'package:first_project_advanced/data/network/dio_factory.dart';
import 'package:first_project_advanced/data/repository/repository_impl.dart';
import 'package:first_project_advanced/domain/repository/repository.dart';
import 'package:first_project_advanced/domain/usecase/forgot_password_use_case.dart';
import 'package:first_project_advanced/domain/usecase/home_usecase.dart';
import 'package:first_project_advanced/domain/usecase/login_use_case.dart';
import 'package:first_project_advanced/domain/usecase/register_usecase.dart';
import 'package:first_project_advanced/domain/usecase/stores_datails_usecase.dart';
import 'package:first_project_advanced/pressentaion/forgot_password/forgot_password_viewmodel.dart';
import 'package:first_project_advanced/pressentaion/login/viewmodel/login_view_model.dart';
import 'package:first_project_advanced/pressentaion/main/pages/home/view_model/home_view_model.dart';
import 'package:first_project_advanced/pressentaion/register/register_viewmodel.dart';
import 'package:first_project_advanced/pressentaion/store_details/store_details_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/network/network_info.dart';


final instance = GetIt.instance;

Future<void> initAppModule() async {
  // app module, its a module where we put all generic dependencies

  // shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  Dio dio = await instance<DioFactory>().getDio();
  //app service client
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance<AppServiceClient>()));

  // local data source
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  // repository

  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance(), instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

initForgotPasswordModule() {
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    instance.registerFactory<ForgotPasswordUseCase>(
        () => ForgotPasswordUseCase(instance()));
    instance.registerFactory<ForgotPasswordViewModel>(
        () => ForgotPasswordViewModel(instance()));
  }
}

initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance
        .registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(instance()));
    instance.registerFactory<ImagePicker>(() => ImagePicker());
  }
}

initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
    instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));
  }
}

initStoreDetailsModule() {
  if (!GetIt.I.isRegistered<StoreDetailsUseCase>()) {
    instance.registerFactory<StoreDetailsUseCase>(
        () => StoreDetailsUseCase(instance()));
    instance.registerFactory<StoreDetailsViewModel>(
        () => StoreDetailsViewModel(instance()));
  }
}