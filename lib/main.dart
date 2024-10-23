import 'package:first_project_advanced/app/app.dart';
import 'package:first_project_advanced/app/di.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLoginModule();
  runApp(MyApp());
}
