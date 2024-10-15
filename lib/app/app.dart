import 'package:first_project_advanced/pressentaion/resources/routes_manager.dart';
import 'package:first_project_advanced/pressentaion/resources/theme_manger.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal(); //named private constructor

  static const MyApp _instance = MyApp._internal(); // single instance

  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
    );
  }
}
