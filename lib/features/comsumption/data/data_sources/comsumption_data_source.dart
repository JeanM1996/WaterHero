import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/core/data/network/firebase_rest.dart';
import 'package:waterhero/core/data/network/http_client.dart';

final comsumptionDataSourceProvider = Provider<ComsumptionDataSource>(
  (ref) => ComsumptionDataSourceImpl(FirebaseRest()),
);

abstract class ComsumptionDataSource {
  Future<HttpServiceResponse> getCompsutionRegisters(String deviceId);
}

class ComsumptionDataSourceImpl extends ComsumptionDataSource {
  ComsumptionDataSourceImpl(this.rest);
  final FirebaseRest rest;

  @override
  Future<HttpServiceResponse> getCompsutionRegisters(String deviceId) async {
    return rest.getCollectionWhere('bluesDeviceEvents', 'best_id', deviceId);
  }
}
