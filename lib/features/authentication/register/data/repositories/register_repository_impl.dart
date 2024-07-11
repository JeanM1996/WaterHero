import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/core/domain/failures/common_failure.dart';
import 'package:waterhero/features/authentication/register/data/data_sources/register_data_source.dart';
import 'package:waterhero/features/authentication/register/domain/repositories/register_repository.dart';

final registerRepositoryProvider = Provider<RegisterRepository>(
  (ref) => RegisterRepositoryImpl(ref.read(registerDataSourceProvider)),
);

class RegisterRepositoryImpl implements RegisterRepository {
  RegisterRepositoryImpl(this.dataSource);

  final RegisterDataSource dataSource;

  @override
  Future<Either<CommonFailure, bool>> register({
    required String email,
    required String password,
    required String name,
    required String lastName,
    required String serviceCode,
  }) async {
    try {
      final response = await dataSource.register(
        email,
        password,
        name,
        lastName,
        serviceCode,
      );
      if (response.success!) {
        return right(true);
      }
      throw Exception();
    } catch (e) {
      return left(
        const CommonFailure.server(code: 500, message: 'Bad request'),
      );
    }
  }
}
