import 'package:waterhero/core/presentation/utils/icons_paths.dart';
import 'package:waterhero/features/main/domain/select_option.dart';

class NavbarBottomState {
  NavbarBottomState({this.option, this.warning = false});
  SelectOption? option;
  bool? warning;

  NavbarBottomState copyWith({
    SelectOption? option,
    bool? warning,
  }) {
    return NavbarBottomState(
      option: option ??
          SelectOption(
            label: 'Inicio',
            value: 1,
            icon: iconsPaths.iconComsumption,
          ),
      warning: warning ?? false,
    );
  }
}
