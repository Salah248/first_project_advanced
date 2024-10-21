import 'package:first_project_advanced/pressentaion/base/base_view_model.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  // inputs

  @override
  void start() {}

  @override
  void dispose() {}

  @override
  //  implement inputPassword
  Sink get inputPassword => throw UnimplementedError();

  @override
  //  implement inputUserName
  Sink get inputUserName => throw UnimplementedError();

  @override
  setPassword(String password) {
    // implement setPassword
    throw UnimplementedError();
  }

  @override
  setUserName(String userName) {
    //  implement setUserName
    throw UnimplementedError();
  }

  @override
  login() {
    // implement login
    throw UnimplementedError();
  }

  // outputs

  @override
  // implement outIsPasswordValid
  Stream<bool> get outIsPasswordValid => throw UnimplementedError();

  @override
  //  implement outIsUserNameValid
  Stream<bool> get outIsUserNameValid => throw UnimplementedError();
}

mixin LoginViewModelInputs {
  setUserName(String userName);
  setPassword(String password);
  login();

  Sink get inputUserName;
  Sink get inputPassword;
}

mixin LoginViewModelOutputs {
  Stream<bool> get outIsUserNameValid;
  Stream<bool> get outIsPasswordValid;
}
