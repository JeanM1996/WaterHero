import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/features/tips/data/data_sources/tips_data_source.dart';
import 'package:waterhero/features/tips/domain/repositories/tips_repository.dart';

//provider
final tipsRepositoryProvider = Provider<TipsRepository>(
  (ref) => TipsRepositoryImpl(
    ref.watch(tipsDataSourceProvider),
  ),
);

class TipsRepositoryImpl implements TipsRepository {
  TipsRepositoryImpl(this.dataSource);

  final TipsDataSource dataSource;
}
