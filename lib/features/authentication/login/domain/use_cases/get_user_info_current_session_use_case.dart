import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/core/domain/failures/common_failure.dart';
import 'package:waterhero/features/authentication/login/data/repositories/login_repository_impl.dart';
import 'package:waterhero/features/authentication/login/domain/repositories/login_repository.dart';

final getUserInfoCurrentSessionUseCaseProvider =
    Provider<GetUserInfoCurrentSessionUseCase>(
  (ref) =>
      GetUserInfoCurrentSessionUseCaseImp(ref.read(loginRepositoryProvider)),
);

abstract class GetUserInfoCurrentSessionUseCase {
  Future<Either<CommonFailure, String>> execute();
}

class GetUserInfoCurrentSessionUseCaseImp
    implements GetUserInfoCurrentSessionUseCase {
  GetUserInfoCurrentSessionUseCaseImp(this.repository);

  final LoginRepository repository;

  @override
  Future<Either<CommonFailure, String>> execute() async {
    return repository.getUserInfoCurrentSession();
  }
}
