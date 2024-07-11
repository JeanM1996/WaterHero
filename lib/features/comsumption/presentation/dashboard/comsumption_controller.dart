import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/features/comsumption/presentation/dashboard/comsumption_state.dart';

class ComsumptionController extends StateNotifier<ComsumptionState> {
  ComsumptionController() : super(ComsumptionState());

  dynamic setIsLoading(isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }
}

final comsumptionController =
    StateNotifierProvider<ComsumptionController, ComsumptionState>((ref) {
  return ComsumptionController();
});
