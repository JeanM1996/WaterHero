import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterhero/features/authentication/restore_password/domain/use_cases/restore_use_case.dart';
import 'package:waterhero/features/authentication/restore_password/presentation/restore_state.dart';

class RestoreController extends StateNotifier<RestoreState> {
  RestoreController(this.loginUseCase) : super(const RestoreState());
  final RestoreUseCase loginUseCase;

  // ignore: long-method, required logic
  Future<String> login(String email, String password) async {
    final storage = await SharedPreferences.getInstance();

    await storage.setString('token', '');
    return '';
  }
}

final loginController =
    StateNotifierProvider.autoDispose<RestoreController, RestoreState>((ref) {
  return RestoreController(
    ref.read(restoreUseCaseProvider),
  );
});
