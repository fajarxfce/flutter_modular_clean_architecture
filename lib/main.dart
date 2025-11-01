import 'package:flutter/material.dart';
import 'package:flutter_modular_clean_architecture/di/di.dart';
import 'package:flutter_modular_clean_architecture/router/app_router.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: getIt.get<AppRouter>().config());
  }
}
