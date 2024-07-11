import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/app.dart';
import 'package:waterhero/default_firebase_options.dart';

Future<void> initApp(String flavor) async {
  WidgetsFlutterBinding.ensureInitialized();
  await _defineEnvFileFromFlavor(flavor: flavor);
  await Firebase.initializeApp(
    name: 'waterhero',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

  //crashlytics
  //validate if is in debug mode
  if (!kDebugMode) {
  } else {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }

  runApp(const ProviderScope(child: App()));
}

dynamic _defineEnvFileFromFlavor({String? flavor}) async {
  if (flavor == 'prod') {
    await dotenv.load(fileName: 'env');
  } else {
    await dotenv.load(fileName: 'env.$flavor');
  }
}
