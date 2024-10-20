import 'package:dartz/dartz.dart';
import 'package:first_project_advanced/data/network/failure.dart';

abstract class BaseUseCase<In, Out> {
  Future<Either<Failure, Out>> execure(In input);
}
