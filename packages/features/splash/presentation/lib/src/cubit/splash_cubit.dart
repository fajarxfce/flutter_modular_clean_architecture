import 'package:database/database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:navigation/app_navigator.dart';

part 'splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  final CredentialRepository _credentialRepository;
  final AppNavigator _appNavigator;

  SplashCubit(this._credentialRepository, this._appNavigator)
    : super(SplashInitial());

  Future<void> checkAuthStatus() async {
    emit(SplashChecking());

    await Future.delayed(const Duration(milliseconds: 1500));

    final token = await _credentialRepository.getAccessToken();

    if (token != null && token.isNotEmpty) {
      _appNavigator.navigateToMain();
    } else {
      _appNavigator.navigateToOnboarding();
    }
  }
}
