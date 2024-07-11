import 'package:flutter/widgets.dart';
import 'package:waterhero/core/presentation/utils/icons_paths.dart';

class AnimatedImageBackground extends StatelessWidget {
  const AnimatedImageBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      iconsPaths.backroundOfficial,
      //all fit screen
      fit: BoxFit.cover,
    );
  }
}
