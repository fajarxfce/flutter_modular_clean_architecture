import 'package:flutter/rendering.dart';
import 'package:login_presentation/src/bloc/login_event.dart';
import 'package:login_presentation/src/bloc/login_state.dart';
import 'package:login_presentation/src/bloc/login_effect.dart';
import 'package:widgets/formz.dart';
import 'package:navigation/app_navigator.dart';
import 'package:shared/shared.dart';

@injectable
class LoginBloc extends BaseBloc<LoginEvent, LoginUiState, LoginEffect> {
  final AppNavigator _appNavigator;
  LoginBloc(this._appNavigator) : super(LoginUiState.initial()) {
    on<OnNavigateToRegisterEvent>(_onNavigateToRegister);
    on<OnEmailChangedEvent>(_onEmailChanged);
    on<OnPasswordChangedEvent>(_onPasswordChanged);
    on<OnLoginSubmittedEvent>(_onLoginSubmitted);
  }

  Future<void> _onNavigateToRegister(
    OnNavigateToRegisterEvent event,
    Emitter<LoginUiState> emit,
  ) async {
    await _appNavigator.navigateToRegister();
  }

  Future<void> _onEmailChanged(
    OnEmailChangedEvent event,
    Emitter<LoginUiState> emit,
  ) async {
    final email = EmailInput.dirty(event.email);
    debugPrint('Email changed: ${state.isFormValid}');
    emit(state.copyWith(email: email));
  }

  Future<void> _onPasswordChanged(
    OnPasswordChangedEvent event,
    Emitter<LoginUiState> emit,
  ) async {
    final password = PasswordInput.dirty(event.password);
    debugPrint('Password changed: ${state.isFormValid}');
    emit(state.copyWith(password: password));
  }

  Future<void> _onLoginSubmitted(
    OnLoginSubmittedEvent event,
    Emitter<LoginUiState> emit,
  ) async {
    // Validate before proceeding
    if (!state.isFormValid) {
      emitEffect(const ShowErrorDialog('Please fix validation errors'));
      return;
    }

    emit(state.copyWith(status: LoginStatus.loading));

    await Future.delayed(const Duration(seconds: 2));

    // Use formz validated values
    final isSuccess = state.email.isValid && state.password.isValid;

    if (isSuccess) {
      emit(state.copyWith(status: LoginStatus.success));

      emitEffect(const ShowSuccessSnackbar('Login successful!'));
      // emitEffect(const PlaySound('Playing peter pan sound'));
      await _appNavigator.navigateToMain();
    } else {
      emit(state.copyWith(status: LoginStatus.initial));

      emitEffect(const ShowErrorDialog('Invalid email or password'));
    }
  }
}
