import 'dart:async';

import 'package:first_project_advanced/pressentaion/common/state_renderer/state_rendere_impl.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  // shared variables and function that will be used through any view model.

  final StreamController _inputStreamController =
      BehaviorSubject<FlowState>();

  @override
  Sink get inputState => _inputStreamController.sink;

  @override
  Stream<FlowState> get outputState => _inputStreamController.stream.map(
        (flowState) => flowState,
      );

  @override
  void dispose() {
    _inputStreamController.close();
  }
}

abstract class BaseViewModelInputs {
  void start() {} // start view model job

  void dispose() {} // will be called when view model dies

  Sink get inputState;
}

mixin BaseViewModelOutputs {
  // will be implemented later

  Stream<FlowState> get outputState;
}
