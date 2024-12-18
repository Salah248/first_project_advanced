import 'package:dartz/dartz.dart';
import 'package:first_project_advanced/domain/models/models.dart';

import '../../data/network/failure.dart';
import '../../data/network/requests.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);

  Future<Either<Failure, String>> forgotPassword(String email);

  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest);

  Future<Either<Failure, HomeObject>> getHomeData();

  Future<Either<Failure, StoreDetails>> getStoreDetails();
}