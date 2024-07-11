import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main_state.dart';

class MainController extends StateNotifier<MainState> {
  MainController() : super(MainState());
}

final mainController = StateNotifierProvider<MainController, MainState>((ref) {
  return MainController();
});
