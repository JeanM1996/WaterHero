import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/core/data/network/http_client.dart';

final tipsDataSourceProvider = Provider<TipsDataSource>(
  (ref) => TipsDataSourceImpl(HttpClient()),
);

abstract class TipsDataSource {}

class TipsDataSourceImpl extends TipsDataSource {
  TipsDataSourceImpl(this.httpClient);
  final HttpClient httpClient;
}
