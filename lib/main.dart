import 'package:flutter/material.dart';
import 'package:flutter_modular_clean_architecture/di/di.dart';
import 'package:flutter_modular_clean_architecture/router/app_router.dart';
import 'package:flutter_modular_clean_architecture/ui/theme.dart';
import 'package:network/network.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  // Verify network module is registered
  final dio = getIt<Dio>();
  final config = getIt<NetworkConfig>();
  debugPrint('✅ Network module initialized');
  debugPrint('📡 Base URL: ${config.baseUrl}');
  debugPrint('🔌 Dio instance: ${dio.hashCode}');

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
