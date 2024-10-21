import 'dart:async';

import 'package:first_project_advanced/pressentaion/base/base_view_model.dart';
import 'package:first_project_advanced/pressentaion/common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNamerStreamController =
      StreamController<String>.broadcast();

  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  var loginObjects = LoginObject('', '');

  // inputs

  @override
  void start() {}

  @override
  void dispose() {
    _userNamerStreamController.close();
    _passwordStreamController.close();
  }

  @override
  //  implement inputPassword
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  //  implement inputUserName
  Sink get inputUserName => _userNamerStreamController.sink;

  @override
  setPassword(String password) {
    inputPassword.add(password);
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
  }

  @override
  login() {
    // implement login
    throw UnimplementedError();
  }

  // outputs

  @override
  // implement outIsPasswordValid
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream.map(
        (password) => _isPasswordValid(password),
      );

  @override
  //  implement outIsUserNameValid
  Stream<bool> get outIsUserNameValid => _passwordStreamController.stream.map(
        (userName) => _isUserNameValid(userName),
      );

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }
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
