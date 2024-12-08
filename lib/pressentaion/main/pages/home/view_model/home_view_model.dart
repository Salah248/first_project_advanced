// ignore_for_file: void_checks

import 'dart:async';
import 'dart:ffi';
import 'package:first_project_advanced/pressentaion/common/state_renderer/state_rendere_impl.dart';
import 'package:first_project_advanced/pressentaion/common/state_renderer/state_renderer.dart';
import 'package:rxdart/rxdart.dart';
import 'package:first_project_advanced/domain/models/models.dart';
import 'package:first_project_advanced/domain/usecase/home_usecase.dart';
import 'package:first_project_advanced/pressentaion/base/base_view_model.dart';

class HomeViewModel extends BaseViewModel with HomeViewModelInput,HomeViewModelOutput   {


   final StreamController _homeViewObjectStreamController = BehaviorSubject<HomeViewObject>();
     

  final HomeUseCase _homeUsecase;

  HomeViewModel(this._homeUsecase);


 // -- inputs

  @override
  void start() {
    _getHomeData();
  }

  @override
  void dispose() {
    _homeViewObjectStreamController.close();
    super.dispose();
  }

  _getHomeData() async {
    inputState.add(
      LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState,
      ),
    );
    (await _homeUsecase.execute(Void))
        .fold(
      (failure) => {
        // left => failure
        inputState.add(
          ErrorState(
            StateRendererType.fullScreenErrorState,
            failure.message,
          ),
        ),
        // ignore: avoid_print
        print(failure.message)
      },
      (homeObject) {
        // raight => data (success)



        // content
        inputState.add(ContentState());

       inputHomeData.add(HomeViewObject(homeObject.data.stores,
          homeObject.data.services, homeObject.data.banners));

      },
    );
  }
  


    @override
  Sink get inputHomeData => _homeViewObjectStreamController.sink;
  
  // --- outputs


  
  @override
  Stream<HomeViewObject> get outputHomeData => _homeViewObjectStreamController.stream.map((data) =>data ,);
}


mixin HomeViewModelInput{
Sink get inputHomeData;


}


mixin HomeViewModelOutput{
  
  Stream<HomeViewObject> get outputHomeData;
}

class HomeViewObject {
  List<Store> stores;
  List<Service> services;
  List<BannerAd> banners;

  HomeViewObject(this.stores, this.services, this.banners);
}