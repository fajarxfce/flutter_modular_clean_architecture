import 'package:flutter/material.dart';
import 'package:login_presentation/src/bloc/login_bloc.dart';
import 'package:login_presentation/src/bloc/login_effect.dart';
import 'package:login_presentation/src/bloc/login_state.dart';
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

class _LoginPageState extends BasePageState<LoginPage, LoginBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return BlocEffectListener<LoginBloc, LoginEvent, LoginUiState, LoginEffect>(
      listener: (context, effect) => _handleEffects(context, effect),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.hello != null) ...[
                Text(
                  widget.hello!,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
              ],

              BlocSelector<
                LoginBloc,
                LoginUiState,
                ({bool isLoading, String email})
              >(
                selector: (state) => (
                  isLoading: state.status == LoginStatus.loading,
                  email: state.email,
                ),
                builder: (context, data) {
                  return TextField(
                    onChanged: (value) {
                      onEvent(OnEmailChangedEvent(value));
                    },
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    enabled: !data.isLoading,
                  );
                },
              ),
              const SizedBox(height: 16),

              BlocSelector<
                LoginBloc,
                LoginUiState,
                ({bool isLoading, String password})
              >(
                selector: (state) => (
                  isLoading: state.status == LoginStatus.loading,
                  password: state.password,
                ),
                builder: (context, data) {
                  return TextField(
                    onChanged: (value) {
                      context.read<LoginBloc>().add(
                        OnPasswordChangedEvent(value),
                      );
                    },
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                    enabled: !data.isLoading,
                  );
                },
              ),
              const SizedBox(height: 24),

              // ✅ Include email+password values to detect changes!
              BlocSelector<
                LoginBloc,
                LoginUiState,
                ({bool isLoading, String email, String password})
              >(
                selector: (state) => (
                  isLoading: state.status == LoginStatus.loading,
                  email: state.email, // ✅ Track actual value
                  password: state.password, // ✅ Track actual value
                ),
                builder: (context, data) {
                  // Compute isEnabled here from actual values
                  final isEnabled =
                      data.email.isNotEmpty && data.password.isNotEmpty;

                  return AppButton.primary(
                    text: 'Sign In',
                    onPressed: (data.isLoading || !isEnabled)
                        ? null
                        : () {
                            context.read<LoginBloc>().add(
                              const OnLoginSubmittedEvent(),
                            );
                          },
                    fullWidth: true,
                    isLoading: data.isLoading,
                  );
                },
              ),
              const SizedBox(height: 16),

              BlocSelector<LoginBloc, LoginUiState, bool>(
                selector: (state) => state.status == LoginStatus.loading,
                builder: (context, isLoading) {
                  return AppButton.secondary(
                    text: 'Go to Register',
                    onPressed: isLoading
                        ? null
                        : () {
                            context.read<LoginBloc>().add(
                              const OnNavigateToRegisterEvent(),
                            );
                          },
                    fullWidth: true,
                  );
                },
              ),
              const SizedBox(height: 24),

              BlocSelector<LoginBloc, LoginUiState, bool>(
                selector: (state) => state.status == LoginStatus.loading,
                builder: (context, isLoading) {
                  return Center(
                    child: TextButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              // TODO: Implement forgot password
                            },
                      child: const Text('Forgot Password?'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🎯 Handle all side effects (single-shot events) in one place
  void _handleEffects(BuildContext context, LoginEffect effect) {
    // ✅ Navigate to Register
    if (effect is NavigateToRegister) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Navigate to Register (implement with AppNavigator)'),
        ),
      );
    }

    // ✅ Navigate to Dashboard
    if (effect is NavigateToDashboard) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Navigate to Dashboard (implement with AppNavigator)'),
        ),
      );
    }

    // ✅ Show Error Dialog
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

    // ✅ Show Success Snackbar
    if (effect is ShowSuccessSnackbar) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(effect.message),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
    }
  }
}
