import 'dart:async';
import 'dart:ffi';
import 'package:first_project_advanced/pressentaion/common/state_renderer/state_rendere_impl.dart';
import 'package:first_project_advanced/pressentaion/common/state_renderer/state_renderer.dart';
import 'package:rxdart/rxdart.dart';
import 'package:first_project_advanced/domain/models/models.dart';
import 'package:first_project_advanced/domain/usecase/home_usecase.dart';
import 'package:first_project_advanced/pressentaion/base/base_view_model.dart';

class HomeViewModel extends BaseViewModel with HomeViewModelInput,HomeViewModelOutput   {
   final StreamController _bannersStreamController = BehaviorSubject<List<BannerAd>>();
     
  final StreamController _servicesStreamController =
      BehaviorSubject<List<Service>>();
  final StreamController _storesStreamController =
      BehaviorSubject<List<Store>>();

  final HomeUseCase _homeUsecase;

  HomeViewModel(this._homeUsecase);


 // -- inputs

  @override
  void start() {
    _getHomeData();
  }

  @override
  void dispose() {
    _bannersStreamController.close();
    _servicesStreamController.close();
    _storesStreamController.close();
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
        print(failure.message)
      },
      (homeObject) {
        // raight => data (success)



        // content
        inputState.add(ContentState());

        inputBanners.add(homeObject.data?.banners);

        inputServices.add(homeObject.data?.services);

        inputStores.add(homeObject.data?.stores);

      },
    );
  }
  

  @override
  Sink get inputBanners => _bannersStreamController.sink;
  
  @override
  Sink get inputServices => _servicesStreamController.sink;
  
  @override
  Sink get inputStores => _storesStreamController.sink;
  
  // --- outputs

  @override
  Stream<List<BannerAd>> get outputBanners => _bannersStreamController.stream.map((banners) => banners,);
  
  @override
  Stream<List<Service>> get outputServices => _servicesStreamController.stream.map((services) =>services ,);
  
  @override
  Stream<List<Store>> get outputStores => _storesStreamController.stream.map((stores) => stores ,);
}


mixin HomeViewModelInput{
Sink get inputStores;
Sink get inputServices;
Sink get inputBanners;

}


mixin HomeViewModelOutput{
  
  Stream<List<Store>> get outputStores;

  Stream<List<Service>> get outputServices;

  Stream<List<BannerAd>> get outputBanners;

}