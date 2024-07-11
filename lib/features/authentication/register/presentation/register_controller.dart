import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterhero/features/authentication/register/domain/use_cases/register_use_case.dart';
import 'package:waterhero/features/authentication/register/presentation/register_state.dart';

class RegisterController extends StateNotifier<RegisterState> {
  RegisterController(this.registerUseCase) : super(const RegisterState());
  final RegisterUseCase registerUseCase;

  // ignore: long-method, required logic
  Future<bool> register(
    String email,
    String password,
    String name,
    String lastName,
    String serviceCode,
  ) async {
    final storage = await SharedPreferences.getInstance();
    final response = await registerUseCase.execute(
      email: email,
      password: password,
      name: name,
      lastName: lastName,
      serviceCode: serviceCode,
    );

    return response.fold(
      (l) {
        state = state.copyWith(
          isLoading: false,
        );
        return false;
      },
      (r) {
        state = state.copyWith(
          isLoading: false,
        );
        return true;
      },
    );
  }
}

final registerController =
    StateNotifierProvider.autoDispose<RegisterController, RegisterState>((ref) {
  return RegisterController(
    ref.read(registerUseCaseProvider),
  );
});
