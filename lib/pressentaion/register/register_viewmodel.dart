import 'dart:async';

import 'package:analyzer/file_system/file_system.dart';
import 'package:first_project_advanced/domain/usecase/register_usecase.dart';
import 'package:first_project_advanced/pressentaion/base/base_view_model.dart';
import 'package:first_project_advanced/pressentaion/common/state_renderer/state_rendere_impl.dart';

class RegisterViewmodel extends BaseViewModel with RegisterViewModelInput , RegisterViewModelIOutput  {
 

   final StreamController _userNamerStreamController =
      StreamController<String>.broadcast();

  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  final StreamController _emailStreamController =
      StreamController<String>.broadcast();

  final StreamController _mobileNumberStreamController =
      StreamController<String>.broadcast();


  final StreamController _profilePictureStreamController =
      StreamController<String>.broadcast();


  final StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();

 final RegisterUsecase _registerUsecase ;

 RegisterViewmodel(this._registerUsecase);

 var registerObject = RegisterObject('','','','','','');
  
  // input 

   @override
  void start() {
    // view model should tell view please show content state
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    super.dispose();
    _userNamerStreamController.close();
    _passwordStreamController.close();
    _emailStreamController.close();
    _mobileNumberStreamController.close();
    _profilePictureStreamController.close();
    _areAllInputsValidStreamController.close();
  }

   @override
  register() {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  setCountryCode(String countryCode) {
  }

  @override
  setEmail(String email) {
    // TODO: implement setEmail
    throw UnimplementedError();
  }

  @override
  setMobileNumber(String mobileNumber) {
    // TODO: implement setMobileNumber
    throw UnimplementedError();
  }

  @override
  setPassword(String password) {
   inputPassword.add(password);
   registerObject = registerObject.copyWith(password);
validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    // TODO: implement setProfilePicture
    throw UnimplementedError();
  }

  @override
  setUserName(String userName) {
     inputUserName.add(userName);
    registerObject = registerObject.copyWith(userName: userName);
    validate(); // to check
  }
  

   @override
  // implement inputAllInputsValid
  Sink get inputAllInputsValid =>_areAllInputsValidStreamController.sink ;

  @override
  // implement inputEmail
  Sink get inputEmail => _emailStreamController.sink;

  @override
  //  implement inputMobileNumber
  Sink get inputMobileNumber => _mobileNumberStreamController.sink;

  @override
  //  implement inputPassword
  Sink get inputPassword =>_passwordStreamController.sink;

  @override
  //  implement inputProfilePicture
  Sink get inputProfilePicture => _profilePictureStreamController.sink;

  @override
  // 
  Sink get inputUserName => _userNamerStreamController.sink;

  // output

@override
  // TODO: implement outputAreAllInputsValid
  Stream<bool> get outputAreAllInputsValid => throw UnimplementedError();

  @override
  // TODO: implement outputErrorEmail
  Stream<String?> get outputErrorEmail => throw UnimplementedError();

  @override
  // TODO: implement outputErrorMobileNumber
  Stream<String?> get outputErrorMobileNumber => throw UnimplementedError();

  @override
  // TODO: implement outputErrorPassword
  Stream<String?> get outputErrorPassword => throw UnimplementedError();

  @override
  // TODO: implement outputErrorUserName
  Stream<String?> get outputErrorUserName => throw UnimplementedError();

  @override
  // TODO: implement outputIsEmailValid
  Stream<bool> get outputIsEmailValid => throw UnimplementedError();

  @override
  // TODO: implement outputIsMobileNumberValid
  Stream<bool> get outputIsMobileNumberValid => throw UnimplementedError();

  @override
  // TODO: implement outputIsPasswordValid
  Stream<bool> get outputIsPasswordValid => throw UnimplementedError();

  @override
  // TODO: implement outputIsUserNameValid
  Stream<bool> get outputIsUserNameValid => throw UnimplementedError();

  @override
  // TODO: implement outputProfilePicture
  Stream<File> get outputProfilePicture => throw UnimplementedError();

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