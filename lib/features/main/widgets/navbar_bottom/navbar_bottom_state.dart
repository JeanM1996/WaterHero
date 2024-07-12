import 'dart:ui';

import 'package:waterhero/core/presentation/utils/icons_paths.dart';
import 'package:waterhero/features/main/domain/select_option.dart';

class NavbarBottomState {
  NavbarBottomState({
    this.option,
    this.warning = false,
    this.locale = const Locale('es'),
  });
  SelectOption? option;
  bool? warning;
  Locale? locale;

  NavbarBottomState copyWith({
    SelectOption? option,
    bool? warning,
    Locale? locale,
  }) {
    return NavbarBottomState(
      option: option ??
          SelectOption(
            label: 'Inicio',
            value: 1,
            icon: iconsPaths.iconComsumption,
          ),
      warning: warning ?? false,
      locale: locale ?? const Locale('es'),
    );
  }
}
