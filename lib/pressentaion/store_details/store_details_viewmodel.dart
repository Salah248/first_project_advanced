
// ignore_for_file: void_checks

import 'dart:async';
import 'dart:ffi';

import 'package:first_project_advanced/domain/models/models.dart';
import 'package:first_project_advanced/domain/usecase/stores_datails_usecase.dart';
import 'package:first_project_advanced/pressentaion/base/base_view_model.dart';
import 'package:first_project_advanced/pressentaion/common/state_renderer/state_rendere_impl.dart';
import 'package:first_project_advanced/pressentaion/common/state_renderer/state_renderer.dart';
import 'package:rxdart/rxdart.dart';

class StoreDetailsViewModel extends BaseViewModel
    with StoreDetailsViewModelInput, StoreDetailsViewModelOutput {
  final _storeDetailsStreamController = BehaviorSubject<StoreDetails>();

  final StoreDetailsUseCase storeDetailsUseCase;

  StoreDetailsViewModel(this.storeDetailsUseCase);

  @override
  start() async {
    _loadData();
  }

  _loadData() async {
    inputState.add(
      LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState),
    );
    (await storeDetailsUseCase.execute(Void)).fold(
      (failure) {
        inputState.add(
          ErrorState(StateRendererType.fullScreenErrorState, failure.message),
        );
      },
      (storeDetails) async {
        inputState.add(ContentState());
        inputStoreDetails.add(storeDetails);
      },
    );
  }

  @override
  void dispose() {
    _storeDetailsStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputStoreDetails => _storeDetailsStreamController.sink;

  //output
  @override
  Stream<StoreDetails> get outputStoreDetails =>
      _storeDetailsStreamController.stream.map((stores) => stores);
}

mixin StoreDetailsViewModelInput {
  Sink get inputStoreDetails;
}

mixin StoreDetailsViewModelOutput {
  Stream<StoreDetails> get outputStoreDetails;
}
