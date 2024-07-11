import 'package:waterhero/core/presentation/design/tokens/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, String>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<String> {
  ThemeNotifier() : super("light");

  Future<void> initTheme() async {
    SharedPreferences storage = await SharedPreferences.getInstance();

    /// Obtener thema actual
    String theme = storage.getString("theme") ?? 'light';

    /// Actualizar colores
    colors = theme == 'dark' ? darkColors : lightColors;

    /// Actualizar estado provider
    state = theme;
  }

  void switchTheme() async {
    SharedPreferences storage = await SharedPreferences.getInstance();

    /// Obtener thema actual
    String theme = storage.getString("theme") ?? 'light';

    /// Actualizar colores
    colors = theme == 'light' ? darkColors : lightColors;

    /// Actualizar valor en storage
    storage.setString('theme', theme == 'dark' ? 'light' : 'dark');

    /// Actualizar estado provider
    state = storage.getString('theme')!;
  }
}
