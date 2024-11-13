import 'package:first_project_advanced/app/constants.dart';
import 'package:first_project_advanced/pressentaion/common/state_renderer/state_renderer.dart';
import 'package:first_project_advanced/pressentaion/resources/strings_manager.dart';
import 'package:flutter/material.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
  bool isDialogShowing = false;
}

// loading state (POPUP , FULL SCREEN)

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String? message;

  LoadingState({
    required this.stateRendererType,
    String message = AppStrings.loading,
  });
  @override
  String getMessage() => message ?? AppStrings.loading;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// error state (POPUP , FULL SCREEN)
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// success state
class SuccessState extends FlowState {
  String message;
  
SuccessState(this.message);

  @override
  String getMessage() =>message;
  
  @override
  StateRendererType getStateRendererType() => StateRendererType.popupSuccessState;
}


// content state
class ContentState extends FlowState {
  ContentState();
  @override
  String getMessage() => Constants.empty;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}

// empty  state
class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.fullScreenEmptyState;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(
    BuildContext context,
    Widget contentScreenWidget,
    Function retryActionFunction,
  ) {
    switch (runtimeType) {
      case const (LoadingState):
        {
          if (getStateRendererType() == StateRendererType.popupLoadingState) {
            // show popup loading
            showPopup(
              context,
              getStateRendererType(),
              getMessage(),
            );

            // show content ui of screen
            return contentScreenWidget;
          } else {
            // full screen  loading state
            return StateRenderer(
                message: getMessage(),
                stateRendererType: getStateRendererType(),
                retryActionFunction: retryActionFunction);
          }
        }
      case const (ErrorState):
        {
          dismissDialog(context);
          if (getStateRendererType() == StateRendererType.popupErrorState) {
            // show popup error
            showPopup(context, getStateRendererType(), getMessage());
            // show content ui of the screen
            return contentScreenWidget;
          } else {
            // full screen error state
            return StateRenderer(
                message: getMessage(),
                stateRendererType: getStateRendererType(),
                retryActionFunction: retryActionFunction);
          }
        }
      case  const (SuccessState):
        {
          dismissDialog(context);
            // show popup success
            showPopup(context, getStateRendererType(), getMessage(),titel: AppStrings.success,);
            // show content ui of the screen
            return contentScreenWidget;
            
        }
      case const (EmptyState):
        {
          return StateRenderer(
              message: getMessage(),
              stateRendererType: getStateRendererType(),
              retryActionFunction: retryActionFunction);
        }
      case const (ContentState):
        {
          dismissDialog(context);

          return contentScreenWidget;
        }
      default:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
    }
  }

  _isCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  dismissDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  void showPopup(BuildContext context, StateRendererType stateRendererType,
      String message, { String titel =Constants.empty}) {
    if (!isDialogShowing) {
      isDialogShowing = true;
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return StateRenderer(
                stateRendererType: stateRendererType,
                message: message,
                titel: titel,
                retryActionFunction: () {},
              );
            },
          ).then(
            (_) {
              // Reset the flag when the dialog is closed
              isDialogShowing = false;
            },
          );
        },
      );
    }
  }
}
