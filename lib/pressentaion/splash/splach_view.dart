import 'dart:async';

import 'package:first_project_advanced/pressentaion/resources/assets_manager.dart';
import 'package:first_project_advanced/pressentaion/resources/color_manager.dart';
import 'package:first_project_advanced/pressentaion/resources/routes_manager.dart';
import 'package:flutter/material.dart';

class SplachView extends StatefulWidget {
  const SplachView({super.key});

  @override
  State<SplachView> createState() => _SplachViewState();
}

class _SplachViewState extends State<SplachView> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(
      const Duration(seconds: 3),
      _goNext, // تمرير الدالة كمرجع
    );
  }

  _goNext() {
    Navigator.pushReplacementNamed(
      context,
      Routes.onBoardingRoute,
    );
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(
        child: Image.asset(
          ImageAssets.splachLogo,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
