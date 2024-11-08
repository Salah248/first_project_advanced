import 'package:dartz/dartz.dart';
import 'package:first_project_advanced/data/network/failure.dart';
import 'package:first_project_advanced/data/network/requests.dart';
import 'package:first_project_advanced/domain/models/models.dart';

abstract class Repository {
  Future<Either<Failure, Authentiction>> login(LoginRequest loginRequest);
  Future<Either<Failure, String>> forgotPassword(String email);
}
