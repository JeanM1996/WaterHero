import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterhero/features/authentication/register/domain/use_cases/register_use_case.dart';
import 'package:waterhero/features/authentication/register/presentation/register_state.dart';

class RegisterController extends StateNotifier<RegisterState> {
  RegisterController(this.loginUseCase) : super(const RegisterState());
  final RegisterUseCase loginUseCase;

  // ignore: long-method, required logic
  Future<String> login(String email, String password) async {
    final storage = await SharedPreferences.getInstance();

    await storage.setString('token', '');
    return '';
  }
}

final registerController =
    StateNotifierProvider.autoDispose<RegisterController, RegisterState>((ref) {
  return RegisterController(
    ref.read(registerUseCaseProvider),
  );
});
