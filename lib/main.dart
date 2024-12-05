import 'package:first_project_advanced/app/app.dart';
import 'package:first_project_advanced/app/di.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // First, initialize the app module which includes the Repository registration
  await initAppModule();



  runApp(MyApp());
}
