import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/features/authentication/restore_password/data/data_sources/restore_data_source.dart';
import 'package:waterhero/features/authentication/restore_password/domain/repositories/restore_repository.dart';

final restoreRepositoryProvider = Provider<RestoreRepository>(
  (ref) => RestoreRepositoryImpl(ref.read(restoreDataSourceProvider)),
);

class RestoreRepositoryImpl implements RestoreRepository {
  RestoreRepositoryImpl(this.dataSource);

  final RestoreDataSource dataSource;
}
