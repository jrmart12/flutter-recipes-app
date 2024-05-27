import 'package:auto_route/auto_route.dart';
import 'package:gotrue/src/types/user.dart';
import 'package:recipes_app/auth/views/splash_page.dart';
import '../auth/views/login_page.dart';
import '../auth/views/register_page.dart';
import '../auth/views/reset_password_page.dart';
import '../home/views/home_page.dart';
import '../home/views/main_page.dart';
import '../recipes/views/categories_page.dart';
import '../recipes/views/favorites_page.dart';
import '../recipes/views/search_page.dart';
import '../user/views/profile_page.dart';
import 'package:flutter/material.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: MainRoute.page, children: [
          AutoRoute(page: HomeRoute.page),
          AutoRoute(page: CategoriesRoute.page),
          AutoRoute(page: FavoritesRoute.page),
          AutoRoute(page: ProfileRoute.page),
          AutoRoute(page: SearchRoute.page),
        ]),
        AutoRoute(
          page: SplashRoute.page,
          initial: true,
        ),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: ResetPasswordRoute.page),
      ];
}
