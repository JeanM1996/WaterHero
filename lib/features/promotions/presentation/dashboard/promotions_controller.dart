import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/features/promotions/presentation/dashboard/promotions_state.dart';

class PromotionsController extends StateNotifier<PromotionsState> {
  PromotionsController() : super(PromotionsState());

  dynamic setIsLoading(isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }
}

final promotionsController =
    StateNotifierProvider<PromotionsController, PromotionsState>((ref) {
  return PromotionsController();
});
