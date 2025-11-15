import 'package:flutter/material.dart';
import 'package:login_presentation/login.dart';
import 'package:login_presentation/src/bloc/login_bloc.dart';
import 'package:login_presentation/src/bloc/login_state.dart';
import 'package:login_presentation/src/bloc/login_event.dart';
import 'package:shared/shared.dart';
import 'package:widgets/widgets.dart';

@RoutePage()
class LoginPage
    extends BaseStateless<LoginEvent, LoginUiState, LoginEffect, LoginBloc> {
  final String? hello;
  LoginPage({super.key, @queryParam this.hello});

  @override
  void onEffect(BuildContext context, LoginEffect effect) {
    super.onEffect(context, effect);
    if (effect is PlaySound) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(effect.soundName)));
    }
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                return AppTextField(
                  label: 'Email',
                  placeholder: 'Enter your email',
                  errorText: data.email.isEmpty ? 'Email is required' : null,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(Icons.email),
                  onChanged: (value) =>
                      context.read<LoginBloc>().add(OnEmailChangedEvent(value)),
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
                return AppTextField(
                  label: 'Password',
                  placeholder: 'Enter your password',
                  errorText: data.password.isEmpty
                      ? 'Password is required'
                      : null,
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon: Icon(Icons.password),
                  onChanged: (value) => context.read<LoginBloc>().add(
                    OnPasswordChangedEvent(value),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            BlocSelector<
              LoginBloc,
              LoginUiState,
              ({bool isFormValid, bool isLoading})
            >(
              selector: (state) => (
                isFormValid: state.isFormValid,
                isLoading: state.status == LoginStatus.loading,
              ),
              builder: (context, data) {
                return AppButton.primary(
                  text: 'Sign In',
                  onPressed: (!data.isFormValid)
                      ? null
                      : () {
                          context.read<LoginBloc>().add(
                            const OnLoginSubmittedEvent(),
                          );
                        },
                  fullWidth: true,
                  isLoading: data.isLoading,
                  isEnabled: data.isFormValid,
                  size: AppButtonSize.large,
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
                  size: AppButtonSize.large,
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
        ).withPadding(all: 16),
      ),
    );
  }
}
