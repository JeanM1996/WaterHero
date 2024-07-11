import 'package:dartz/dartz.dart';
import 'package:waterhero/core/domain/failures/common_failure.dart';

abstract class LoginRepository {
  Future<Either<CommonFailure, bool>> login({
    required String email,
    required String password,
  });
}
