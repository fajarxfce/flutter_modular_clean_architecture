import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:navigation/app_navigator.dart';
import 'package:onboarding_presentation/src/bloc/onboarding_event.dart';
import 'package:onboarding_presentation/src/bloc/onboarding_state.dart';

@injectable
class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingUiState> {
  final AppNavigator _appNavigator;

  OnboardingBloc(this._appNavigator) : super(const OnboardingUiState()) {
    on<OnNavigateToLogin>(_onNavigateToLogin);
  }

  Future<void> _onNavigateToLogin(
    OnNavigateToLogin event,
    Emitter<OnboardingUiState> emit,
  ) async {
    await _appNavigator.navigateToLogin('Hello from OnboardingBloc');
  }
}
