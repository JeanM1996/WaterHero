import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/core/domain/failures/common_failure.dart';
import 'package:waterhero/features/authentication/restore_password/data/repositories/restore_repository_impl.dart';
import 'package:waterhero/features/authentication/restore_password/domain/repositories/restore_repository.dart';

final restoreUseCaseProvider = Provider<RestoreUseCase>(
  (ref) => RestoreUseCaseImp(ref.read(restoreRepositoryProvider)),
);

abstract class RestoreUseCase {
  Future<Either<CommonFailure, bool>> restore(String email);
}

class RestoreUseCaseImp implements RestoreUseCase {
  RestoreUseCaseImp(this.repository);

  final RestoreRepository repository;

  @override
  Future<Either<CommonFailure, bool>> restore(String email) async {
    return repository.restore(email);
  }
}
