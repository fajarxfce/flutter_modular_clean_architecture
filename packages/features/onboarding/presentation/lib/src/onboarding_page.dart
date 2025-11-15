import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:onboarding_presentation/src/bloc/onboarding_bloc.dart';
import 'package:onboarding_presentation/src/bloc/onboarding_event.dart';

@RoutePage()
class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<OnboardingBloc>(),
      child: const _OnBoardingPageContent(),
    );
  }
}

class _OnBoardingPageContent extends StatelessWidget {
  const _OnBoardingPageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the OnBoarding Page!',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<OnboardingBloc>().add(OnNavigateToLogin());
              },
              child: const Text('Go to Login'),
            ),
          ],
        ),
      ),
    );
  }
}
