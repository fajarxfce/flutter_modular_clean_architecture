import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:login_presentation/src/bloc/login_bloc.dart';
import 'package:login_presentation/src/bloc/login_state.dart';
import 'package:login_presentation/src/bloc/login_effect.dart';
import 'package:login_presentation/src/bloc/login_event.dart';
import 'package:shared/shared.dart';
import 'package:widgets/widgets.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  final String? hello;
  const LoginPage({super.key, @queryParam this.hello});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<LoginBloc>(),
      child: Builder(
        builder: (context) {
          return BlocEffectConsumer<LoginBloc, LoginUiState, LoginEffect>(
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Login'),
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.primaryContainer,
                ),
                body: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Greeting
                      if (widget.hello != null) ...[
                        Text(
                          widget.hello!,
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                      ],

                      // Email TextField
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        enabled: state.status != LoginStatus.loading,
                      ),
                      const SizedBox(height: 16),

                      // Password TextField
                      TextField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                        enabled: state.status != LoginStatus.loading,
                      ),
                      const SizedBox(height: 24),

                      // ✅ Sign In Button - shows loading indicator based on STATE
                      AppButton.primary(
                        text: 'Sign In',
                        onPressed: state.status == LoginStatus.loading
                            ? null
                            : () {
                                context.read<LoginBloc>().add(
                                  OnLoginSubmittedEvent(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                              },
                        fullWidth: true,
                        isLoading: state.status == LoginStatus.loading,
                      ),
                      const SizedBox(height: 16),

                      // ✅ Register Button - uses EFFECT for navigation
                      AppButton.secondary(
                        text: 'Go to Register',
                        onPressed: state.status == LoginStatus.loading
                            ? null
                            : () {
                                context.read<LoginBloc>().add(
                                  const OnNavigateToRegisterEvent(),
                                );
                              },
                        fullWidth: true,
                      ),
                      const SizedBox(height: 24),

                      // Forgot Password Link
                      TextButton(
                        onPressed: state.status == LoginStatus.loading
                            ? null
                            : () {
                                // TODO: Implement forgot password
                              },
                        child: const Text('Forgot Password?'),
                      ),
                    ],
                  ),
                ),
              );
            },

            // 🎯 Effect Listener: Handle SINGLE-SHOT EVENTS (navigation, dialogs, etc)
            effectListener: (context, effect) {
              // ✅ Navigate to Register - single-shot event
              if (effect is NavigateToRegister) {
                // TODO: Use AppNavigator or auto_route navigation
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Navigate to Register (implement with AppNavigator)',
                    ),
                  ),
                );
              }

              // ✅ Navigate to Dashboard - single-shot event
              if (effect is NavigateToDashboard) {
                // TODO: Use AppNavigator or auto_route navigation
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Navigate to Dashboard (implement with AppNavigator)',
                    ),
                  ),
                );
              }

              // ✅ Show Error Dialog - single-shot event
              if (effect is ShowErrorDialog) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Login Failed'),
                    content: Text(effect.message),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }

              // ✅ Show Success Snackbar - single-shot event
              if (effect is ShowSuccessSnackbar) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(effect.message),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
