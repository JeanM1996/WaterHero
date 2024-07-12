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
        title: 'Duchate máximo en 5 minutos',
        description: 'Para ahorrar agua, cierra la llave mientras te enjabonas',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0YDECSzk-UNikZSWjDfr6t9yWmhJDNJvPNQ&s',
      ),
      TipsModel(
        title: 'Usa la lavadora con carga completa',
        description: 'Cada vez que lavas ropa con la lavadora, ahorras agua',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqzbn_b_df4GVPUbuasvYSjZyEj7WPs3_egw&s',
      ),
      TipsModel(
        title: 'Cierra la llave mientras te cepillas los dientes',
        description: 'Con esto ahorras hasta 19 litros de agua',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpyXG0FUx0ba3NyqnGaXjbyc1a_dRRFFmoW8Y2FFXD6gGoMvSS_GS7hbJ8CYYZ0CW-FDw&usqp=CAU',
      ),
      TipsModel(
        title: 'Revisa que los empaques de tus llaves no tengan fugas',
        description:
            'Una llave con fuga puede desperdiciar hasta 20 litros de agua al día',
        imageUrl:
            'https://st1.uvnimg.com/e5/5f/1f7abd684a7a88a18b3176c2cc3f/29_fugas_istock.jpg',
      ),
      TipsModel(
        title: 'No laves tu carro a chorros de agua',
        description: 'Usa un balde y una esponja para lavar tu carro',
        imageUrl:
            'https://st1.uvnimg.com/dims4/default/2399016/2147483647/thumbnail/480x270/quality/75/?url=https%3A%2F%2Fuvn-brightspot.s3.amazonaws.com%2Fassets%2Fvixes%2Fimj%2Fhogartotal%2F7%2F7-tips-para-ahorrar-agua-en-el-lavado-de-tu-auto-3.jpg',
      ),
      TipsModel(
        title: 'Al menos dos veces al año, limpia tus tinacos y cisternas',
        description: 'Esto evita que se acumulen bacterias y hongos en el agua',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8TPBBg-KfKxgawWq6i5q4SN6uxrJvydLJow&s',
      ),
    ];

    state = state.copyWith(tips: tips, isLoading: false);
  }
}

final tipsControllerProvider =
    StateNotifierProvider<TipsController, TipsState>((ref) {
  return TipsController();
});
