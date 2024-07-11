import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/core/domain/failures/common_failure.dart';
import 'package:waterhero/features/authentication/restore_password/data/data_sources/restore_data_source.dart';
import 'package:waterhero/features/authentication/restore_password/domain/repositories/restore_repository.dart';

final restoreRepositoryProvider = Provider<RestoreRepository>(
  (ref) => RestoreRepositoryImpl(ref.read(restoreDataSourceProvider)),
);

class RestoreRepositoryImpl implements RestoreRepository {
  RestoreRepositoryImpl(this.dataSource);

  final RestoreDataSource dataSource;

  @override
  Future<Either<CommonFailure, bool>> restore(String email) async {
    try {
      final response = await dataSource.restore(email);
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
