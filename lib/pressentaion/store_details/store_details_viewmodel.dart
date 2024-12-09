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
  // StreamController
  final _storeDetailsStreamController = BehaviorSubject<StoreDetails>();

  final StoreDetailsUseCase storeDetailsUseCase;

  StoreDetailsViewModel(this.storeDetailsUseCase);

  @override
  start() async {
    _loadData();
  }

  _loadData() async {
    // عرض حالة تحميل البيانات
    inputState.add(
      LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState),
    );

    // تنفيذ الـ UseCase للحصول على البيانات
    (await storeDetailsUseCase.execute(Void)).fold(
          (failure) {
        // في حالة الفشل، عرض حالة الخطأ
        inputState.add(
          ErrorState(StateRendererType.fullScreenErrorState, failure.message),
        );
      },
          (storeDetails) {
        // في حالة النجاح، عرض حالة المحتوى
        inputState.add(ContentState());

        // تحقق من أن الـ StreamController غير مغلق قبل إضافة البيانات
        if (!_storeDetailsStreamController.isClosed) {
          inputStoreDetails.add(storeDetails);
        } else {
          print("StreamController is already closed. Cannot add new events.");
        }
      },
    );
  }

  @override
  void dispose() {
    // إغلاق الـ StreamController عند الانتهاء
    _storeDetailsStreamController.close();
    super.dispose();
  }

  // Input
  @override
  Sink get inputStoreDetails => _storeDetailsStreamController.sink;

  // Output
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