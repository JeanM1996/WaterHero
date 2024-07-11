import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/core/data/network/http_client.dart';

final comsumptionDataSourceProvider = Provider<ComsumptionDataSource>(
  (ref) => ComsumptionDataSourceImpl(HttpClient()),
);

abstract class ComsumptionDataSource {}

class ComsumptionDataSourceImpl extends ComsumptionDataSource {
  ComsumptionDataSourceImpl(this.httpClient);
  final HttpClient httpClient;
}
