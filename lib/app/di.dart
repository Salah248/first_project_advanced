import 'package:first_project_advanced/app/app_prefs.dart';
import 'package:get_it/get_it.dart';
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
}

Future<void> initLoginModule() async {}
