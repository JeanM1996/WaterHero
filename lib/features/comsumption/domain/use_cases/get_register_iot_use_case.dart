import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/core/domain/failures/common_failure.dart';
import 'package:waterhero/features/comsumption/data/repositories/comsumption_repository_impl.dart';
import 'package:waterhero/features/comsumption/domain/models/register_iot.dart';
import 'package:waterhero/features/comsumption/domain/repositories/comsumption_repository.dart';

final getRegisterIotUseCaseProvider = Provider<GetRegisterIotUseCase>(
  (ref) => GetRegisterIotUseCaseImpl(ref.read(comsumptionRepositoryProvider)),
);

abstract class GetRegisterIotUseCase {
  Future<Either<CommonFailure, List<RegisterIot>>> execute(String id);
}

class GetRegisterIotUseCaseImpl implements GetRegisterIotUseCase {
  GetRegisterIotUseCaseImpl(this.repository);

  final ComsumptionRepository repository;

  @override
  Future<Either<CommonFailure, List<RegisterIot>>> execute(String id) {
    return repository.getRegistersDevice(id);
  }
}
