import 'package:dio/dio.dart';
import 'package:first_project_advanced/app/constants.dart';
import 'package:first_project_advanced/data/response/responses.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part "app_api.g.dart";

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServicesClient {
  factory AppServicesClient(Dio dio, {String baseUrl}) = _AppServicesClient;

  @POST("/customers/login")
  Future<AuthentictionResponse> login(
    @Field('email') String email,
    @Field('password') String password,
  );
}
