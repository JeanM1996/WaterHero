import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/core/domain/failures/common_failure.dart';
import 'package:waterhero/features/authentication/register/data/repositories/register_repository_impl.dart';
import 'package:waterhero/features/authentication/register/domain/repositories/register_repository.dart';

final registerUseCaseProvider = Provider<RegisterUseCase>(
  (ref) => RegisterUseCaseImp(ref.read(registerRepositoryProvider)),
);

abstract class RegisterUseCase {
  Future<Either<CommonFailure, bool>> execute({
    required String email,
    required String password,
    required String name,
    required String lastName,
    required String serviceCode,
  });
}

class RegisterUseCaseImp implements RegisterUseCase {
  RegisterUseCaseImp(this.repository);

  final RegisterRepository repository;

  @override
  Future<Either<CommonFailure, bool>> execute({
    required String email,
    required String password,
    required String name,
    required String lastName,
    required String serviceCode,
  }) async {
    return repository.register(
      email: email,
      password: password,
      name: name,
      lastName: lastName,
      serviceCode: serviceCode,
    );
  }
}
