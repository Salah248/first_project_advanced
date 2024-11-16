
import 'package:dartz/dartz.dart';
import 'package:first_project_advanced/data/network/failure.dart';
import 'package:first_project_advanced/data/network/requests.dart';
import 'package:first_project_advanced/domain/models/models.dart';
import 'package:first_project_advanced/domain/repository/repository.dart';
import 'package:first_project_advanced/domain/usecase/base_use_case.dart';

class RegisterUsecase implements BaseUseCase<RegisterUseCaseInput, Authentiction> {
  final Repository _repository;

  RegisterUsecase(this._repository);

  @override
  Future<Either<Failure, Authentiction>> execute(
      RegisterUseCaseInput input) async {
    return await _repository.register(
      RegisterRequest(
      input.username,
      input.countryMobileCode,
      input.email,
      input.mobileNumber,
      input.password,
      input.profilePicture
      ),
    );
  }
}

class RegisterUseCaseInput {
 String username;
  String mobileNumber;
  String countryMobileCode;
  String email;
  String password;
  String profilePicture;

  RegisterUseCaseInput(
    this.email,
    this.password,
    this.username,
    this.mobileNumber,
    this.countryMobileCode,
    this.profilePicture,
  );
}
