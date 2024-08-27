import 'package:dartz/dartz.dart';
import 'package:waterhero/core/domain/failures/common_failure.dart';
import 'package:waterhero/features/comsumption/domain/models/register_iot.dart';

abstract class ComsumptionRepository {
  Future<Either<CommonFailure, List<RegisterIot>>> getRegistersDevice(
    String id,
  );
}
