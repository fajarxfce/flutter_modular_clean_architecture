import 'package:auto_route/auto_route.dart';
import 'package:home_presentation/home.dart';
import 'package:login_presentation/login.dart';
import 'package:main_presentation/main_presentation.dart';
import 'package:onboarding_presentation/onboarding.dart';
import 'package:product_presentation/product_presentation.dart';
import 'package:profile_presentation/profile.dart';
import 'package:register_presentation/register.dart';
import 'package:splash_presentation/splash_presentation.dart';
import 'package:transaction_presentation/transaction_presentation.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: OnBoardingRoute.page),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(
      page: MainRoute.page,
      children: [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: ProfileRoute.page),
      ],
    ),
    AutoRoute(page: TransactionRoute.page),
    AutoRoute(page: ProductRoute.page),
    AutoRoute(page: AddProductRoute.page),
  ];
}
