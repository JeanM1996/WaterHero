import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/splash_page/splash_page_state.dart';

class SplashPageController extends StateNotifier<SplashPageState> {
  SplashPageController() : super(SplashPageState());

  // ignore: long-method, required logic to avoid duplied code
  Future<bool> loadInitialData() async {
    setIsLoading(value: true);
    return true;
  }

  dynamic setIsLoading({required bool value}) {
    state = state.copyWith(isLoading: value);
  }
}

final splashPageController =
    StateNotifierProvider<SplashPageController, SplashPageState>((ref) {
  return SplashPageController();
});
