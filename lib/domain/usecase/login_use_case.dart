import 'package:dartz/dartz.dart';
import 'package:first_project_advanced/data/network/failure.dart';
import 'package:first_project_advanced/data/network/requests.dart';
import 'package:first_project_advanced/domain/models/models.dart';
import 'package:first_project_advanced/domain/repository/repository.dart';
import 'package:first_project_advanced/domain/usecase/base_use_case.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentiction> {
  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentiction>> execute(
      LoginUseCaseInput input) async {
    return await _repository.login(
      LoginRequest(
        input.email,
        input.password,
      ),
    );
  }
}

class LoginUseCaseInput {
  String email;
  String password;
  LoginUseCaseInput(this.email, this.password);
}
