import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:first_project_advanced/app/app_prefs.dart';
import 'package:first_project_advanced/app/constants.dart';
import 'package:first_project_advanced/app/di.dart';
import 'package:first_project_advanced/pressentaion/common/state_renderer/state_rendere_impl.dart';
import 'package:first_project_advanced/pressentaion/register/register_viewmodel.dart';
import 'package:first_project_advanced/pressentaion/resources/assets_manager.dart';
import 'package:first_project_advanced/pressentaion/resources/color_manager.dart';
import 'package:first_project_advanced/pressentaion/resources/routes_manager.dart';
import 'package:first_project_advanced/pressentaion/resources/strings_manager.dart';
import 'package:first_project_advanced/pressentaion/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewmodel _viewModel = instance<RegisterViewmodel>();
  final ImagePicker _imagePicker = instance<ImagePicker>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
      _userNameController.addListener(() {
      _viewModel.setUserName(_userNameController.text);
    });
    _emailController.addListener(() {
      _viewModel.setEmail(_emailController.text);
    });

    _passwordController.addListener(() {
      _viewModel.setPassword(_passwordController.text);
    });

    _mobileNumberController.addListener(() {
      _viewModel.setMobileNumber(_mobileNumberController.text);
    });

     _viewModel.isUserRegisterSuccessfullyStreamController.stream.listen(
      (isRegister) {
        if (isRegister) {
          // navigate to main screen
          SchedulerBinding.instance.addPostFrameCallback(
            (_) {
              _appPreferences.setUserLoggedIn();
              Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
            },
          );
        }
      },
    );
    
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
         systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorManager.white,),
        elevation: AppSize.s0,
        backgroundColor: ColorManager.white,
        iconTheme: IconThemeData(color: ColorManager.primary),
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
                context,
                _getContentWidget(),
                () {
                  _viewModel.register();
                },
              ) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p28),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Image.asset(ImageAssets.splachLogo),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<String?>(
                  stream: _viewModel.outputErrorUserName,
                  builder: (context, snapshot) {
                    return TextFormField(
                      style: TextStyle(
                        color: ColorManager.primary,
                        fontSize: AppSize.s14,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      controller: _userNameController,
                      decoration: InputDecoration(
                          hintText: AppStrings.username,
                          labelText: AppStrings.username,
                          errorText: snapshot.data),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.s18,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: AppPadding.p28,
                    right: AppPadding.p28,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CountryCodePicker(
                          initialSelection: '+20',
                          favorite: const ['+39', 'Fr', '+966'],
                          showCountryOnly: true,
                          showOnlyCountryWhenClosed: true,
                          hideMainText: true,
                          onChanged: (country) {
                            // update view model with code
                            _viewModel.setCountryCode(
                                country.dialCode ?? Constants.token);
                          },
                          onInit: (country) {
                             // update view model with code
                            _viewModel.setCountryCode(
                                country?.dialCode ?? Constants.token);
                          },
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: StreamBuilder<String?>(
                          stream: _viewModel.outputErrorMobileNumber,
                          builder: (context, snapshot) {
                            return TextFormField(
                              style: TextStyle(
                                color: ColorManager.primary,
                                fontSize: AppSize.s14,
                              ),
                              keyboardType: TextInputType.phone,
                              controller: _mobileNumberController,
                              decoration: InputDecoration(
                                hintText: AppStrings.mobileNumber,
                                labelText: AppStrings.mobileNumber,
                                errorText: snapshot.data,
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: AppSize.s18,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.p28,
                  right: AppPadding.p28,
                ),
                child: StreamBuilder<String?>(
                  stream: _viewModel.outputErrorEmail,
                  builder: (context, snapshot) {
                    return TextFormField(
                      style: TextStyle(
                        color: ColorManager.primary,
                        fontSize: AppSize.s14,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: InputDecoration(
                          hintText: AppStrings.emailHint,
                          labelText: AppStrings.emailHint,
                          errorText: snapshot.data),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.s20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.p28,
                  right: AppPadding.p28,
                ),
                child: StreamBuilder<String?>(
                  stream: _viewModel.outputErrorPassword,
                  builder: (context, snapshot) {
                    return TextFormField(
                      style: TextStyle(
                        color: ColorManager.primary,
                        fontSize: AppSize.s14,
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordController,
                      decoration: InputDecoration(
                          hintText: AppStrings.password,
                          labelText: AppStrings.password,
                          errorText: snapshot.data),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.s18,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.p28,
                  right: AppPadding.p28,
                ),
                child: Container(
                  height: AppSize.s40,
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.all(Radius.circular(AppSize.s8)),
                    border: Border.all(
                      color: ColorManager.grey,
                    ),
                  ),
                  child: GestureDetector(
                    child: _getMediaWidget(),
                    onTap: () {
                      _showPicer(context);
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: AppSize.s40,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.p28,
                  right: AppPadding.p28,
                ),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outputAreAllInputsValid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s40,
                      child: ElevatedButton(
                        onPressed: (snapshot.data ?? false)
                            ? () {
                                _viewModel.register();
                              }
                            : null,
                        child: Text(
                          AppStrings.register,
                          style: TextStyle(
                            color: ColorManager.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.s18,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.p28,
                  right: AppPadding.p28,
                  top: AppPadding.p18,
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    AppStrings.alreadyHaveAccount,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getMediaWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.p8, right: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Flexible(child: Text(AppStrings.profilePicture)),
          Flexible(
            child: StreamBuilder<File>(
              stream: _viewModel.outputProfilePicture,
              builder: (context, snapshot) {
                return _imagePicketByUser(snapshot.data);
              },
            ),
          ),
          Flexible(
            child: SvgPicture.asset(ImageAssets.photoCamera),
          ),
        ],
      ),
    );
  }

  _showPicer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                trailing: const Icon(Icons.forward),
                leading: const Icon(Icons.camera),
                title: const Text(AppStrings.photoGallery),
                onTap: () {
                  _imageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                trailing: const Icon(Icons.forward),
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text(AppStrings.photoCamera),
                onTap: () {
                  _imageFromCamera();
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        );
      },
    );
  }

  _imageFromGallery() async {
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    _viewModel.setProfilePicture(File(image?.path ?? ''));
  }

  _imageFromCamera() async {
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    _viewModel.setProfilePicture(File(image?.path ?? ''));
  }

  Widget _imagePicketByUser(File? image) {
    if (image != null && image.path.isNotEmpty) {
      // return image
      return Image.file(image);
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    //  call view model dispose

    _viewModel.dispose();
    super.dispose();
  }
}
