import 'package:first_project_advanced/data/network/app_api.dart';
import 'package:first_project_advanced/data/network/requests.dart';
import 'package:first_project_advanced/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthentictionResponse> login(LoginRequest loginRequest);
  Future<AuthentictionResponse> register(RegisterRequest registerRequest);
  Future<ForgotPasswordResponse> forgotPassword(String email);
}

class RemoteDataSourseImpl implements RemoteDataSource {
  final AppServicesClient _appServicesClient;

  RemoteDataSourseImpl(this._appServicesClient);

  @override
  Future<AuthentictionResponse> login(LoginRequest loginRequest) async {
    return await _appServicesClient.login(
      loginRequest.email,
      loginRequest.password,
    );
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(String email) async {
    return await _appServicesClient.forgotPassword(email);
  }

  @override
  Future<AuthentictionResponse> register(
      RegisterRequest registerRequest) async {
    return await _appServicesClient.register(
      registerRequest.username,
      registerRequest.countryMobileCode,
      registerRequest.mobileNumber,
      registerRequest.email,
      registerRequest.password,
     "",
    );
  }
}
