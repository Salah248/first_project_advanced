
import 'package:dartz/dartz.dart';
import 'package:first_project_advanced/data/network/failure.dart';
import 'package:first_project_advanced/domain/models/models.dart';
import 'package:first_project_advanced/domain/usecase/base_use_case.dart';

import '../repository/repository.dart';

class HomeUseCase implements BaseUseCase<void, HomeObject> {
  final Repository _repository;

  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, HomeObject>> execute(void input) async {
    return await _repository.getHomeData();
  }
}