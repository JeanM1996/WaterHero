import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterhero/core/presentation/design/atoms/atoms.dart';
import 'package:waterhero/core/presentation/design/tokens/tokens.dart';
import 'package:waterhero/core/presentation/utils/routes.dart';
import 'package:waterhero/features/main/widgets/animated_image_background.dart';
import 'package:waterhero/features/theme_notifier.dart';
import 'package:waterhero/splash_page/splash_page_controller.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashState();
}

class _SplashState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, _initTheme);
  }

  dynamic _initTheme() async {
    await ref.read(themeProvider.notifier).initTheme();
    final controller = ref.read(splashPageController.notifier);
    final storage = await SharedPreferences.getInstance();
    if (storage.getString('token') != null) {
      final status = await controller.loadInitialData();
      if (status) {
        final keepSession = storage.getBool('keepSession') ?? false;

        if (!keepSession) {
          await storage.clear();
          Future.delayed(const Duration(seconds: 2), () {
            context.go(
              Routes.loginRoute,
            );
          });
        } else {
          Future.delayed(const Duration(seconds: 2), () {
            context.go(
              Routes.comsumptionRoute,
            );
          });
        }
      } else {
        Future.delayed(const Duration(seconds: 2), () {
          context.go(
            Routes.loginRoute,
          );
        });
      }
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        context.go(
          Routes.loginRoute,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            const Positioned.fill(child: AnimatedImageBackground()),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TweenAnimationBuilder(
                      duration: const Duration(seconds: 1),
                      tween: Tween<double>(begin: 0, end: 1),
                      builder: (context, double value, child) {
                        return Opacity(
                          opacity: value,
                          child: child,
                        );
                      },
                      child: //gradient text  native impl
                          const CustomText(
                        'WaterHero',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),
                //CircularProgressIndicator
                TweenAnimationBuilder(
                  duration: const Duration(seconds: 1),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, double value, child) {
                    return Opacity(
                      opacity: value,
                      child: child,
                    );
                  },
                  //resize the indicator
                  child: SizedBox(
                    width: 15,
                    height: 15,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
