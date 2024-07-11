import 'package:dartz/dartz.dart';
import 'package:waterhero/core/domain/failures/common_failure.dart';

abstract class RestoreRepository {
  Future<Either<CommonFailure, bool>> restore(String email);
}
