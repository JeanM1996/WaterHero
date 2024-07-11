import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/features/comsumption/data/data_sources/comsumption_data_source.dart';
import 'package:waterhero/features/comsumption/domain/repositories/comsumption_repository.dart';

//provider
final comsumptionRepositoryProvider = Provider<ComsumptionRepository>(
  (ref) => ComsumptionRepositoryImpl(
    ref.watch(comsumptionDataSourceProvider),
  ),
);

class ComsumptionRepositoryImpl implements ComsumptionRepository {
  ComsumptionRepositoryImpl(this.dataSource);

  final ComsumptionDataSource dataSource;
}
