import 'package:first_project_advanced/data/network/failure.dart';
import 'package:first_project_advanced/pressentaion/resources/strings_manager.dart';
import 'package:flutter/material.dart';

enum StateRendererType {
  // popup stetes (dialog)
  popupLoadingState,
  popupErrorState,

  // full screen stated (full screen)
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,

  // genral
  contentState,
}

class StateRenderer extends StatelessWidget {
  StateRenderer(
      {super.key,
      required this.stateRendererType,
      this.message = AppStrings.loading,
      this.titel = '',
      required this.retryActionFunction});

  final StateRendererType stateRendererType;
  String message;
  String titel;
  final Function retryActionFunction;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
