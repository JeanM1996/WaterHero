import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/core/domain/failures/common_failure.dart';
import 'package:waterhero/features/authentication/login/data/repositories/login_repository_impl.dart';
import 'package:waterhero/features/authentication/login/domain/repositories/login_repository.dart';

final loginUseCaseProvider = Provider<LoginUseCase>(
  (ref) => LoginUseCaseImp(ref.read(loginRepositoryProvider)),
);

abstract class LoginUseCase {
  Future<Either<CommonFailure, bool>> login({
    required String email,
    required String password,
  });
}

class LoginUseCaseImp implements LoginUseCase {
  LoginUseCaseImp(this.repository);

  final LoginRepository repository;

  @override
  Future<Either<CommonFailure, bool>> login({
    required String email,
    required String password,
  }) async {
    return await repository.login(email: email, password: password);
  }
}
