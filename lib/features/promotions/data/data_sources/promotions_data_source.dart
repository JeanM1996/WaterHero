import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/core/data/network/http_client.dart';

final promotionsDataSourceProvider = Provider<PromotionsDataSource>(
  (ref) => PromotionsDataSourceImpl(HttpClient()),
);

abstract class PromotionsDataSource {}

class PromotionsDataSourceImpl extends PromotionsDataSource {
  PromotionsDataSourceImpl(this.httpClient);
  final HttpClient httpClient;
}
