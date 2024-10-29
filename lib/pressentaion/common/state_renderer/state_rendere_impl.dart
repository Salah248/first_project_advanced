import 'package:first_project_advanced/app/constants.dart';
import 'package:first_project_advanced/pressentaion/common/state_renderer/state_renderer.dart';
import 'package:first_project_advanced/pressentaion/resources/strings_manager.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
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
