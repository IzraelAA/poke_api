import 'package:dartz/dartz.dart';
import 'package:poke_api/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
