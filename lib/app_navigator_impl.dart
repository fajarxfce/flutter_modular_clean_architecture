import 'package:flutter_modular_clean_architecture/router/app_router.dart';
import 'package:injectable/injectable.dart';
import 'package:navigation/app_navigator.dart';
import 'package:login_presentation/login.dart';
import 'package:register_presentation/register.dart';

@Injectable(as: AppNavigator)
class AppNavigatorImpl implements AppNavigator {
  final AppRouter _appRouter;
  AppNavigatorImpl(this._appRouter);
  @override
  void navigateToHome() {}

  @override
  void navigateToLogin() {
    _appRouter.replace(const LoginRoute());
  }

  @override
  void navigateToOnboarding() {
    // TODO: implement navigateToOnboarding
  }

  @override
  void navigateToRegister() {
    _appRouter.push(const RegisterRoute());
  }
}
