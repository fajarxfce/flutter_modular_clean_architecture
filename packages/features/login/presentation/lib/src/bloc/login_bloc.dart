import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:login_presentation/src/bloc/login_event.dart';
import 'package:login_presentation/src/bloc/login_state.dart';
import 'package:navigation/app_navigator.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginUiState> {
  final AppNavigator _appNavigator;
  LoginBloc(this._appNavigator) : super(LoginUiState.initial()) {
    on<OnNavigateToRegisterEvent>(_onNavigateToRegister);
  }

  Future<void> _onNavigateToRegister(
    OnNavigateToRegisterEvent event,
    Emitter<LoginUiState> emit,
  ) async {
    _appNavigator.navigateToRegister();
  }
}
