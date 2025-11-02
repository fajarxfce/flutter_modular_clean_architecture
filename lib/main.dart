import 'package:flutter/material.dart';
import 'package:flutter_modular_clean_architecture/di/di.dart';
import 'package:flutter_modular_clean_architecture/router/app_router.dart';
import 'package:flutter_modular_clean_architecture/ui/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
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
