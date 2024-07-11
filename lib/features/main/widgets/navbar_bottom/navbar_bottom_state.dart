import 'package:waterhero/core/presentation/utils/icons_paths.dart';
import 'package:waterhero/features/main/domain/select_option.dart';

class NavbarBottomState {
  NavbarBottomState({this.option});
  SelectOption? option;

  NavbarBottomState copyWith({
    SelectOption? option,
  }) {
    return NavbarBottomState(
      option: option ??
          SelectOption(
              label: 'Inicio', value: 1, icon: iconsPaths.iconComsumption),
    );
  }
}
