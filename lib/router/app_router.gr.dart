// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    CategoriesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CategoriesPage(),
      );
    },
    FavoritesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FavoritesPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginPage(key: args.key),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainPage(),
      );
    },
    MealDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<MealDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MealDetailsPage(
          key: args.key,
          mealId: args.mealId,
        ),
      );
    },
    MealsRoute.name: (routeData) {
      final args = routeData.argsAs<MealsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MealsPage(
          key: args.key,
          categoryName: args.categoryName,
          categoryId: args.categoryId,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfilePage(),
      );
    },
    RecipeDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<RecipeDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RecipeDetailsPage(
          key: args.key,
          recipeId: args.recipeId,
        ),
      );
    },
    RecipeFormRoute.name: (routeData) {
      final args = routeData.argsAs<RecipeFormRouteArgs>(
          orElse: () => const RecipeFormRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RecipeFormPage(
          key: args.key,
          recipe: args.recipe,
        ),
      );
    },
    RegisterRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterRouteArgs>(
          orElse: () => const RegisterRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RegisterPage(key: args.key),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ResetPasswordRouteArgs>(
          orElse: () => const ResetPasswordRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ResetPasswordPage(key: args.key),
      );
    },
    SearchRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SearchPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashPage(),
      );
    },
  };
}

/// generated route for
/// [CategoriesPage]
class CategoriesRoute extends PageRouteInfo<void> {
  const CategoriesRoute({List<PageRouteInfo>? children})
      : super(
          CategoriesRoute.name,
          initialChildren: children,
        );

  static const String name = 'CategoriesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FavoritesPage]
class FavoritesRoute extends PageRouteInfo<void> {
  const FavoritesRoute({List<PageRouteInfo>? children})
      : super(
          FavoritesRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoritesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<LoginRouteArgs> page = PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MealDetailsPage]
class MealDetailsRoute extends PageRouteInfo<MealDetailsRouteArgs> {
  MealDetailsRoute({
    Key? key,
    required String mealId,
    List<PageRouteInfo>? children,
  }) : super(
          MealDetailsRoute.name,
          args: MealDetailsRouteArgs(
            key: key,
            mealId: mealId,
          ),
          initialChildren: children,
        );

  static const String name = 'MealDetailsRoute';

  static const PageInfo<MealDetailsRouteArgs> page =
      PageInfo<MealDetailsRouteArgs>(name);
}

class MealDetailsRouteArgs {
  const MealDetailsRouteArgs({
    this.key,
    required this.mealId,
  });

  final Key? key;

  final String mealId;

  @override
  String toString() {
    return 'MealDetailsRouteArgs{key: $key, mealId: $mealId}';
  }
}

/// generated route for
/// [MealsPage]
class MealsRoute extends PageRouteInfo<MealsRouteArgs> {
  MealsRoute({
    Key? key,
    required String categoryName,
    required String categoryId,
    List<PageRouteInfo>? children,
  }) : super(
          MealsRoute.name,
          args: MealsRouteArgs(
            key: key,
            categoryName: categoryName,
            categoryId: categoryId,
          ),
          initialChildren: children,
        );

  static const String name = 'MealsRoute';

  static const PageInfo<MealsRouteArgs> page = PageInfo<MealsRouteArgs>(name);
}

class MealsRouteArgs {
  const MealsRouteArgs({
    this.key,
    required this.categoryName,
    required this.categoryId,
  });

  final Key? key;

  final String categoryName;

  final String categoryId;

  @override
  String toString() {
    return 'MealsRouteArgs{key: $key, categoryName: $categoryName, categoryId: $categoryId}';
  }
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RecipeDetailsPage]
class RecipeDetailsRoute extends PageRouteInfo<RecipeDetailsRouteArgs> {
  RecipeDetailsRoute({
    Key? key,
    required String recipeId,
    List<PageRouteInfo>? children,
  }) : super(
          RecipeDetailsRoute.name,
          args: RecipeDetailsRouteArgs(
            key: key,
            recipeId: recipeId,
          ),
          initialChildren: children,
        );

  static const String name = 'RecipeDetailsRoute';

  static const PageInfo<RecipeDetailsRouteArgs> page =
      PageInfo<RecipeDetailsRouteArgs>(name);
}

class RecipeDetailsRouteArgs {
  const RecipeDetailsRouteArgs({
    this.key,
    required this.recipeId,
  });

  final Key? key;

  final String recipeId;

  @override
  String toString() {
    return 'RecipeDetailsRouteArgs{key: $key, recipeId: $recipeId}';
  }
}

/// generated route for
/// [RecipeFormPage]
class RecipeFormRoute extends PageRouteInfo<RecipeFormRouteArgs> {
  RecipeFormRoute({
    Key? key,
    RecipeDto? recipe,
    List<PageRouteInfo>? children,
  }) : super(
          RecipeFormRoute.name,
          args: RecipeFormRouteArgs(
            key: key,
            recipe: recipe,
          ),
          initialChildren: children,
        );

  static const String name = 'RecipeFormRoute';

  static const PageInfo<RecipeFormRouteArgs> page =
      PageInfo<RecipeFormRouteArgs>(name);
}

class RecipeFormRouteArgs {
  const RecipeFormRouteArgs({
    this.key,
    this.recipe,
  });

  final Key? key;

  final RecipeDto? recipe;

  @override
  String toString() {
    return 'RecipeFormRouteArgs{key: $key, recipe: $recipe}';
  }
}

/// generated route for
/// [RegisterPage]
class RegisterRoute extends PageRouteInfo<RegisterRouteArgs> {
  RegisterRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          RegisterRoute.name,
          args: RegisterRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const PageInfo<RegisterRouteArgs> page =
      PageInfo<RegisterRouteArgs>(name);
}

class RegisterRouteArgs {
  const RegisterRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'RegisterRouteArgs{key: $key}';
  }
}

/// generated route for
/// [ResetPasswordPage]
class ResetPasswordRoute extends PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ResetPasswordRoute.name,
          args: ResetPasswordRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const PageInfo<ResetPasswordRouteArgs> page =
      PageInfo<ResetPasswordRouteArgs>(name);
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'ResetPasswordRouteArgs{key: $key}';
  }
}

/// generated route for
/// [SearchPage]
class SearchRoute extends PageRouteInfo<void> {
  const SearchRoute({List<PageRouteInfo>? children})
      : super(
          SearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
