import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/features/authentication/login/data/repositories/login_repository_impl.dart';
import 'package:waterhero/features/authentication/restore_password/domain/repositories/restore_repository.dart';

final restoreUseCaseProvider = Provider<RestoreUseCase>(
  (ref) => RestoreUseCaseImp(ref.read(loginRepositoryProvider)),
);

abstract class RestoreUseCase {}

class RestoreUseCaseImp implements RestoreUseCase {
  RestoreUseCaseImp(this.repository);

  final RestoreRepository repository;
}
