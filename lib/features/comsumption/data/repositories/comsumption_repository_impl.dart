import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/core/domain/failures/common_failure.dart';
import 'package:waterhero/features/comsumption/data/data_sources/comsumption_data_source.dart';
import 'package:waterhero/features/comsumption/domain/models/register_iot.dart';
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

  @override
  Future<Either<CommonFailure, List<RegisterIot>>> getRegistersDevice(
    String deviceId,
  ) async {
    try {
      final result = await dataSource.getCompsutionRegisters(
        deviceId,
      );

      if (result.success!) {
        final mapA = jsonDecode(result.body!);

        //convert iterable to list
        final registers = List<RegisterIot>.from(
          mapA.map((x) => RegisterIot.fromJson(x)),
        );

        return right(registers);
      }
      throw Exception();
    } catch (e) {
      print('Error: $e');
      return left(
        const CommonFailure.server(code: 500, message: 'Bad request'),
      );
    }
  }
}
