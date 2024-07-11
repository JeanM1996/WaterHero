import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/features/authentication/login/domain/repositories/login_repository.dart';
import 'package:waterhero/features/authentication/register/data/repositories/register_repository_impl.dart';

final registerUseCaseProvider = Provider<RegisterUseCase>(
  (ref) => RegisterUseCaseImp(ref.read(registerRepositoryProvider)),
);

abstract class RegisterUseCase {}

class RegisterUseCaseImp implements RegisterUseCase {
  RegisterUseCaseImp(this.repository);

  final LoginRepository repository;
}
