// ignore_for_file: constant_identifier_names

import 'package:first_project_advanced/pressentaion/resources/langauge_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_LANG = 'PREFS_KEY_LANG';
const String PREFS_KEY_ONBOARDING_SCREEN_VIEWD =
    'PREFS_KEY_ONBOARDING_SCREEN_VIEWD';
const String PREFS_KEY_IS_USER_LOGED_IN = 'PREFS_KEY_IS_USER_LOGED_IN';

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(PREFS_KEY_LANG);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      // return default lang
      return LangaugeType.ENGLISH.getVlue();
    }
  }

  // ON BOArding
  Future<void> setOnBoardingScreenViewd() async {
    _sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWD, true);
  }

  Future<bool> isOnBoardingScreenViewd() async {
    return _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWD) ??
        false;
  }

  // Login
  Future<void> setUserLoggedIn() async {
    _sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGED_IN, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGED_IN) ?? false;
  }
}
