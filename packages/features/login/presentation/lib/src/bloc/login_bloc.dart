import 'package:login_presentation/src/bloc/login_event.dart';
import 'package:login_presentation/src/bloc/login_state.dart';
import 'package:login_presentation/src/bloc/login_effect.dart';
import 'package:navigation/app_navigator.dart';
import 'package:shared/shared.dart';

@injectable
class LoginBloc extends BlocWithEffect<LoginEvent, LoginUiState, LoginEffect> {
  final AppNavigator _appNavigator;
  LoginBloc(this._appNavigator) : super(LoginUiState.initial()) {
    on<OnNavigateToRegisterEvent>(_onNavigateToRegister);
    on<OnLoginSubmittedEvent>(_onLoginSubmitted);
  }

  Future<void> _onNavigateToRegister(
    OnNavigateToRegisterEvent event,
    Emitter<LoginUiState> emit,
  ) async {
    await _appNavigator.navigateToRegister();
  }

  Future<void> _onLoginSubmitted(
    OnLoginSubmittedEvent event,
    Emitter<LoginUiState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));

    await Future.delayed(const Duration(seconds: 2));

    final isSuccess = event.email == '123';

    if (isSuccess) {
      emit(state.copyWith(status: LoginStatus.success, email: event.email));

      await _appNavigator.navigateToHome();

      emitEffect(const ShowSuccessSnackbar('Login successful!'));
    } else {
      emit(state.copyWith(status: LoginStatus.initial));

      emitEffect(const ShowErrorDialog('Invalid credentials'));
    }
  }
}
