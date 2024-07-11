import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/core/presentation/design/tokens/theme.dart' as t;
import 'package:waterhero/core/presentation/utils/routes.dart';
import 'package:waterhero/features/theme_notifier.dart';
import 'package:waterhero/localization/generated/lang.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        /// Listener theme
        ref.watch(themeProvider);
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: MaterialApp.router(
            title: 'WaterHero',
            theme: t.Theme().theme,
            routerConfig: ref.watch(goRouterProvider),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              Lang.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('es', 'ES'),
            ],
          ),
        );
      },
    );
  }
}
