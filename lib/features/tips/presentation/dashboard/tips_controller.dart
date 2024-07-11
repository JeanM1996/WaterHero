import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/features/tips/domain/models/tips_model.dart';
import 'package:waterhero/features/tips/presentation/dashboard/tips_state.dart';

class TipsController extends StateNotifier<TipsState> {
  TipsController() : super(TipsState());

  dynamic setIsLoading(isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void loadTips() {
    final List<TipsModel> tips;
    tips = [
      TipsModel(
        title: 'Bañarse en 5 minutos',
        description: 'Ahorra agua bañandote en 5 minutos',
        imageUrl: 'https://via.placeholder.com/150',
      ),
      TipsModel(
        title: 'Cerrar la llave',
        description: 'Cierra la llave mientras te cepillas los dientes',
        imageUrl: 'https://via.placeholder.com/150',
      ),
      TipsModel(
        title: 'Lavar el auto',
        description: 'Lava tu auto con un balde y no con manguera',
        imageUrl: 'https://via.placeholder.com/150',
      ),
      TipsModel(
        title: 'Regar plantas',
        description: 'Riega tus plantas en la noche',
        imageUrl: 'https://via.placeholder.com/150',
      ),
    ];

    state = state.copyWith(tips: tips, isLoading: false);
  }
}

final tipsControllerProvider =
    StateNotifierProvider<TipsController, TipsState>((ref) {
  return TipsController();
});
