import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterhero/features/authentication/login/domain/use_cases/login_use_case.dart';
import 'package:waterhero/features/authentication/login/presentation/login_state.dart';

class LoginController extends StateNotifier<LoginState> {
  LoginController(this.loginUseCase) : super(const LoginState());
  final LoginUseCase loginUseCase;

  // ignore: long-method, required logic
  Future<String> login(String email, String password) async {
    final storage = await SharedPreferences.getInstance();

    await storage.setString('token', '');
    return '';
  }
}

final loginController =
    StateNotifierProvider.autoDispose<LoginController, LoginState>((ref) {
  return LoginController(
    ref.read(loginUseCaseProvider),
  );
});
