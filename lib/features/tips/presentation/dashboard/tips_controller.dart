import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/features/tips/presentation/dashboard/tips_state.dart';

class TipsController extends StateNotifier<TipsState> {
  TipsController() : super(TipsState());

  dynamic setIsLoading(isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }
}

final tipsControllerProvider =
    StateNotifierProvider<TipsController, TipsState>((ref) {
  return TipsController();
});
