import 'package:dartz/dartz.dart';
import 'package:first_project_advanced/data/network/failure.dart';
import 'package:first_project_advanced/domain/models/models.dart';
import 'package:first_project_advanced/domain/repository/repository.dart';
import 'package:first_project_advanced/domain/usecase/base_use_case.dart';

class HomeUsecase implements BaseUseCase<void, HomeObject> {
  final Repository _repository;

  HomeUsecase(this._repository);

  @override
  Future<Either<Failure, HomeObject>> execute(void input) async {
    return await _repository.getHomeData();
  }
}