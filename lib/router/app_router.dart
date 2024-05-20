import 'package:auto_route/auto_route.dart';
import 'package:gotrue/src/types/user.dart';
import 'package:recipes_app/auth/views/splash_page.dart';
import '../auth/views/login_page.dart';
import '../auth/views/register_page.dart';
import '../auth/views/reset_password_page.dart';
import '../home/views/home_page.dart';
import 'package:flutter/material.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: ResetPasswordRoute.page),
        AutoRoute(page: HomeRoute.page),
      ];
}
