import 'package:auto_route/auto_route.dart';
import 'package:home_presentation/home.dart';
import 'package:login_presentation/login.dart';
import 'package:main_presentation/main_presentation.dart';
import 'package:onboarding_presentation/onboarding.dart';
import 'package:profile_presentation/profile.dart';
import 'package:register_presentation/register.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: OnBoardingRoute.page, initial: true),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(
      page: MainRoute.page,
      children: [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: ProfileRoute.page),
      ],
    ),
  ];
}
