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
  Future<void> navigateToHome() async {
    // TODO: Create HomeRoute
    // await _appRouter.replace(const HomeRoute());
  }

  @override
  Future<void> navigateToLogin(String? hello) async {
    await _appRouter.replace(LoginRoute(hello: hello));
  }

  @override
  Future<void> navigateToOnboarding() async {
    // TODO: implement navigateToOnboarding
    // await _appRouter.replace(const OnBoardingRoute());
  }

  @override
  Future<void> navigateToRegister() async {
    await _appRouter.push(const RegisterRoute());
  }

  @override
  void navigateBack<T>([T? result]) {
    _appRouter.maybePop(result);
  }

  @override
  Future<T?> navigateToRegisterForResult<T>() async {
    return await _appRouter.push<T>(const RegisterRoute());
  }

  @override
  Future<T?> navigateToAddProduct<T>() async {
    throw UnimplementedError('AddProductRoute not created yet');
  }
}
