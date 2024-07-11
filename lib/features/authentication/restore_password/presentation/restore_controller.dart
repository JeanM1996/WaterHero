import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/features/authentication/restore_password/domain/use_cases/restore_use_case.dart';
import 'package:waterhero/features/authentication/restore_password/presentation/restore_state.dart';

class RestoreController extends StateNotifier<RestoreState> {
  RestoreController(this.restorePassword) : super(const RestoreState());
  final RestoreUseCase restorePassword;

  // ignore: long-method, required logic
  Future<bool> restore(String email) async {
    final result = await restorePassword.restore(email);
    return result.fold(
      (failure) {
        return false;
      },
      (success) {
        return true;
      },
    );
  }
}

final restoreController =
    StateNotifierProvider.autoDispose<RestoreController, RestoreState>((ref) {
  return RestoreController(
    ref.read(restoreUseCaseProvider),
  );
});
