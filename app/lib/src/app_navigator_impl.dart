import 'package:app/src/router/app_router.dart';
import 'package:injectable/injectable.dart';
import 'package:main_presentation/main_presentation.dart';
import 'package:navigation/app_navigator.dart';
import 'package:login_presentation/login.dart';
import 'package:profile_presentation/profile.dart';
import 'package:register_presentation/register.dart';
import 'package:transaction_presentation/transaction_presentation.dart';

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

  @override
  Future<void> navigateToMain() {
    return _appRouter.replace(const MainRoute());
  }

  @override
  Future<void> navigateToProfile() => _appRouter.push(const ProfileRoute());

  @override
  Future<void> navigateToTransaction() =>
      _appRouter.push(const TransactionRoute());
}
