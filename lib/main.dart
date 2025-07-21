import 'package:easy_localization/easy_localization.dart';
import 'package:first_project_advanced/app/app.dart';
import 'package:first_project_advanced/app/di.dart';
import 'package:first_project_advanced/pressentaion/resources/langauge_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  // First, initialize the app module which includes the Repository registration
  await initAppModule();

  runApp(
    EasyLocalization(
      supportedLocales: const [ARABIC_LOCAL, ENGLISH_LOCAL],
      path: ASSET_PATH_LOCALISATIONS,
      child: Phoenix(child: MyApp()),
    ),
  );
}
