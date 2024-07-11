import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/features/promotions/data/data_sources/promotions_data_source.dart';
import 'package:waterhero/features/promotions/domain/repositories/promotions_repository.dart';

//provider
final promotionsRepositoryProvider = Provider<PromotionsRepository>(
  (ref) => PromotionsRepositoryImpl(
    ref.watch(promotionsDataSourceProvider),
  ),
);

class PromotionsRepositoryImpl implements PromotionsRepository {
  PromotionsRepositoryImpl(this.dataSource);

  final PromotionsDataSource dataSource;
}
