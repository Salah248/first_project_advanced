// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:first_project_advanced/app/functions.dart';
import 'package:first_project_advanced/domain/usecase/register_usecase.dart';
import 'package:first_project_advanced/pressentaion/base/base_view_model.dart';
import 'package:first_project_advanced/pressentaion/common/freezed_data_classes.dart';
import 'package:first_project_advanced/pressentaion/common/state_renderer/state_rendere_impl.dart';
import 'package:first_project_advanced/pressentaion/common/state_renderer/state_renderer.dart';
import 'package:first_project_advanced/pressentaion/resources/strings_manager.dart';

class RegisterViewmodel extends BaseViewModel
    with RegisterViewModelInput, RegisterViewModelIOutput {
  final StreamController userNamerStreamController =
      StreamController<String>.broadcast();

 StreamController mobileNumberStreamController =
      StreamController<String>.broadcast();

    StreamController emailStreamController = StreamController<String>.broadcast();
  StreamController passwordStreamController =
      StreamController<String>.broadcast();
  StreamController profilePictureStreamController =
      StreamController<File>.broadcast();
  StreamController areAllInputsValidStreamController =
      StreamController<void>.broadcast();

      final StreamController isUserRegisterSuccessfullyStreamController =
      StreamController<bool>();

  final RegisterUsecase _registerUsecase;

  RegisterViewmodel(this._registerUsecase);

  var registerObject = RegisterObject('', '', '', '', '', '');

  // --- input

  @override
  void start() {
    // view model should tell view please show content state
    inputState.add(ContentState());
  }

  @override
  void dispose() {
     userNamerStreamController.close();
    mobileNumberStreamController.close();
    emailStreamController.close();
    passwordStreamController.close();
    profilePictureStreamController.close();
    areAllInputsValidStreamController.close();
    isUserRegisterSuccessfullyStreamController.close();
    super.dispose();
  }

  @override
  register() async {
    inputState.add(
      LoadingState(
        stateRendererType: StateRendererType.popupLoadingState,
      ),
    );
    (await _registerUsecase.execute(
      RegisterUseCaseInput(
        registerObject.userName,
            registerObject.countryMobileCode,
            registerObject.mobileNumber,
            registerObject.email,
            registerObject.password,
            registerObject.profilePicture

      ),
    ))
        .fold(
      (failure) => {
        // left => failure
        inputState.add(
          ErrorState(
            StateRendererType.popupErrorState,
            failure.message,
          ),
        ),
        print(failure.message)
      },
      (data) {
        // raight => data (success)
        print(data.customer?.name);

        // content
        inputState.add(ContentState());

        // navigate to main screen
          isUserRegisterSuccessfullyStreamController.add(true);
      },
    );
  }

  @override
  setCountryCode(String countryCode) {
    if (countryCode.isNotEmpty) {
      //  update register view object
      registerObject = registerObject.copyWith(countryMobileCode: countryCode);
    } else {
      // reset code value in register view object
      registerObject = registerObject.copyWith(countryMobileCode: "");
    }
    validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (isEmailValid(email)) {
      //  update register view object
      registerObject = registerObject.copyWith(email: email);
    } else {
      // reset email value in register view object
      registerObject = registerObject.copyWith(email: "");
    }
    validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);
    if (_isMobileNumberValid(mobileNumber)) {
      //  update register view object
      registerObject = registerObject.copyWith(mobileNumber: mobileNumber);
    } else {
      // reset mobileNumber value in register view object
      registerObject = registerObject.copyWith(mobileNumber: "");
    }
    validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if (_isPasswordValid(password)) {
      //  update register view object
      registerObject = registerObject.copyWith(password: password);
    } else {
      // reset password value in register view object
      registerObject = registerObject.copyWith(password: "");
    }
    validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    inputProfilePicture.add(profilePicture);
    inputProfilePicture.add(profilePicture);
    if (profilePicture.path.isNotEmpty) {
      //  update register view object
      registerObject =
          registerObject.copyWith(profilePicture: profilePicture.path);
    } else {
      // reset profilePicture value in register view object
      registerObject = registerObject.copyWith(profilePicture: "");
    }
    validate();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    if (_isUserNameValid(userName)) {
      // update register object
      registerObject = registerObject.copyWith(userName: userName);
    } else {
      // reset user name value in register object
      registerObject = registerObject.copyWith(userName: "");
    }
    validate();
  }

  @override
  // implement inputAllInputsValid
  Sink get inputAllInputsValid => areAllInputsValidStreamController.sink;

  @override
  // implement inputEmail
  Sink get inputEmail => emailStreamController.sink;

  @override
  //  implement inputMobileNumber
  Sink get inputMobileNumber => mobileNumberStreamController.sink;

  @override
  //  implement inputPassword
  Sink get inputPassword => passwordStreamController.sink;

  @override
  //  implement inputProfilePicture
  Sink get inputProfilePicture => profilePictureStreamController.sink;

  @override
  //
  Sink get inputUserName => userNamerStreamController.sink;

  // --- output

  @override
  // implement outputAreAllInputsValid
  Stream<bool> get outputAreAllInputsValid =>
      areAllInputsValidStreamController.stream.map(
        (_) => _areAllInputsValid(),
      );

  @override
  // implement outputErrorEmail
  Stream<String?> get outputErrorEmail => outputIsEmailValid.map(
        (isEmail) => isEmail ? null : AppStrings.invalidEmail,
      );

  @override
  // implement outputErrorMobileNumber
  Stream<String?> get outputErrorMobileNumber => outputIsMobileNumberValid.map(
        (isMobileNumber) =>
            isMobileNumber ? null : AppStrings.mobileNumberInvalid,
      );

  @override
  //  implement outputErrorPassword
  Stream<String?> get outputErrorPassword => outputIsPasswordValid.map(
        (isPassword) => isPassword ? null : AppStrings.passwordInvalid,
      );

  @override
  //  implement outputErrorUserName
  Stream<String?> get outputErrorUserName => outputIsUserNameValid.map(
        (isUserName) => isUserName ? null : AppStrings.userNameInvalid,
      );

  @override
  //  implement outputIsEmailValid
  Stream<bool> get outputIsEmailValid => emailStreamController.stream.map(
        (email) => isEmailValid(email),
      );

  @override
  // implement outputIsMobileNumberValid
  Stream<bool> get outputIsMobileNumberValid =>
      mobileNumberStreamController.stream.map(
        (mobileNumber) => _isMobileNumberValid(mobileNumber),
      );

  @override
  // implement outputIsPasswordValid
  Stream<bool> get outputIsPasswordValid => passwordStreamController.stream.map(
        (password) => _isPasswordValid(password),
      );

  @override
  // implement outputIsUserNameValid
  Stream<bool> get outputIsUserNameValid =>
      userNamerStreamController.stream.map(
        (userName) => _isUserNameValid(userName),
      );

  @override
  // implement outputProfilePicture
  Stream<File> get outputProfilePicture =>
      profilePictureStreamController.stream.map(
        (file) => file,
      );

  // --  private functions

  bool _isUserNameValid(String userName) {
    return userName.length >= 8;
  }

  bool _isMobileNumberValid(String mobileNumber) {
    return mobileNumber.length >= 10;
  }

  bool _isPasswordValid(String password) {
    return password.length >= 6;
  }

  bool _areAllInputsValid() {
    return registerObject.countryMobileCode.isNotEmpty &&
        registerObject.mobileNumber.isNotEmpty &&
        registerObject.userName.isNotEmpty &&
        registerObject.email.isNotEmpty &&
        registerObject.password.isNotEmpty &&
        registerObject.profilePicture.isNotEmpty;
  }

  validate() {
    inputAllInputsValid.add(null);
  }
}

mixin RegisterViewModelInput {
  Sink get inputUserName;

  Sink get inputMobileNumber;

  Sink get inputEmail;

  Sink get inputPassword;

  Sink get inputProfilePicture;

  Sink get inputAllInputsValid;

  register();

  setUserName(String userName);

  setMobileNumber(String mobileNumber);

  setCountryCode(String countryCode);

  setEmail(String email);

  setPassword(String password);

  setProfilePicture(File profilePicture);
}

mixin RegisterViewModelIOutput {
  Stream<bool> get outputIsUserNameValid;

  Stream<String?> get outputErrorUserName;

  Stream<bool> get outputIsMobileNumberValid;

  Stream<String?> get outputErrorMobileNumber;

  Stream<bool> get outputIsEmailValid;

  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputIsPasswordValid;

  Stream<String?> get outputErrorPassword;

  Stream<File> get outputProfilePicture;

  Stream<bool> get outputAreAllInputsValid;
}
