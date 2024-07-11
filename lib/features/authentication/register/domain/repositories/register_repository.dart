import 'package:dartz/dartz.dart';
import 'package:waterhero/core/domain/failures/common_failure.dart';

abstract class RegisterRepository {
  //login
  Future<Either<CommonFailure, bool>> register({
    required String email,
    required String password,
    required String name,
    required String lastName,
    required String serviceCode,
  });
}
