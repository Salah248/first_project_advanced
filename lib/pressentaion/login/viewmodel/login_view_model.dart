// ignore_for_file: avoid_print

import 'dart:async';

import 'package:first_project_advanced/domain/usecase/login_use_case.dart';
import 'package:first_project_advanced/pressentaion/base/base_view_model.dart';
import 'package:first_project_advanced/pressentaion/common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNamerStreamController =
      StreamController<String>.broadcast();

  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  final StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();

  //final LoginUseCase _loginUseCase;

  // LoginViewModel(this._loginUseCase);
  LoginViewModel();

  var loginObject = LoginObject('', '');

  // inputs

  @override
  void start() {}

  @override
  void dispose() {
    _userNamerStreamController.close();
    _passwordStreamController.close();
    _areAllInputsValidStreamController.close();
  }

  @override
  //  implement inputPassword
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  //  implement inputUserName
  Sink get inputUserName => _userNamerStreamController.sink;

  @override
  //  implement inputAreAllInputsValid
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    inputAreAllInputsValid.add(null); // to check
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    inputAreAllInputsValid.add(null); // to check
  }

  @override
  login() async {
    // (await _loginUseCase.execute(
    //   LoginUseCaseInput(
    //     loginObject.userName,
    //     loginObject.password,
    //   ),
    // ))
    //     .fold(
    //   (failure) => {
    //     // left => failure
    //     print(failure.message)
    //   },
    //   (data) => {
    //     // raight => data (success)
    //     print(data.customer?.name)
    //   },
    // );
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

  @override
  //  implement outAreAllInputsValid
  Stream<bool> get outAreAllInputsValid =>
      _areAllInputsValidStreamController.stream.map(
        (_) => _areAllInputsValid(),
      );

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  bool _areAllInputsValid() {
    return _isPasswordValid(loginObject.password) &&
        _isUserNameValid(loginObject.userName);
  }
}

mixin LoginViewModelInputs {
  setUserName(String userName);

  setPassword(String password);

  login();

  Sink get inputUserName;

  Sink get inputPassword;

  Sink get inputAreAllInputsValid;
}

mixin LoginViewModelOutputs {
  Stream<bool> get outIsUserNameValid;
  Stream<bool> get outIsPasswordValid;
  Stream<bool> get outAreAllInputsValid;
}
