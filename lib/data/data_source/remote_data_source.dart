import 'package:first_project_advanced/data/network/app_api.dart';
import 'package:first_project_advanced/data/network/requests.dart';
import 'package:first_project_advanced/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthentictionResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourseImpl implements RemoteDataSource {
  AppServicesClient _appServicesClient;

  RemoteDataSourseImpl(this._appServicesClient);

  @override
  Future<AuthentictionResponse> login(LoginRequest loginRequest) async {
    return await _appServicesClient.login(
      loginRequest.email,
      loginRequest.password,
    );
  }
}
