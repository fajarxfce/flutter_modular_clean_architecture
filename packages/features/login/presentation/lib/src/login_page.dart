import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:login_presentation/src/bloc/login_bloc.dart';
import 'package:login_presentation/src/bloc/login_event.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<LoginBloc>(),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Welcome to the Login Page!'),
            OutlinedButton(
              onPressed: () {
                context.read<LoginBloc>().add(
                  const OnNavigateToRegisterEvent(),
                );
              },
              child: const Text('Go to Register'),
            ),
          ],
        ),
      ),
    );
  }
}
