import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/features/authentication/login/data/repositories/login_repository_impl.dart';
import 'package:waterhero/features/authentication/login/domain/repositories/login_repository.dart';

final loginUseCaseProvider = Provider<LoginUseCase>(
  (ref) => LoginUseCaseImp(ref.read(loginRepositoryProvider)),
);

abstract class LoginUseCase {}

class LoginUseCaseImp implements LoginUseCase {
  LoginUseCaseImp(this.repository);

  final LoginRepository repository;
}
