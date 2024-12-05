import 'package:first_project_advanced/app/di.dart';
import 'package:first_project_advanced/pressentaion/main/pages/home/view_model/home_view_model.dart';
import 'package:first_project_advanced/pressentaion/resources/strings_manager.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

final HomeViewModel _viewModel = instance<HomeViewModel>();


_bind(){
  _viewModel.start();
}

@override
  void initState() {
    _bind();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(AppStrings.home),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}