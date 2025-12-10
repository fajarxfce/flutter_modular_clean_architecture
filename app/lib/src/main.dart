import 'package:flutter/material.dart';
import 'package:app/src/di/di.dart';
import 'package:app/src/router/app_router.dart';
import 'package:app/src/ui/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import '../firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Setup Crashlytics error handler
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // Setup DI
  configureDependencies();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final theme = MaterialTheme(textTheme);

    return MaterialApp.router(
      routerConfig: getIt.get<AppRouter>().config(),
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: ThemeMode.system,
    );
  }
}
