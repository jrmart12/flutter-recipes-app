import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:recipes_app/auth/blocs/auth_cubit.dart';
import 'package:recipes_app/core/di/injection.config.dart';
import 'package:recipes_app/recipes/data_sources/recipe_remote_data_source.dart';
import 'package:recipes_app/user/blocs/user_cubit.dart';
import 'package:recipes_app/user/data_sources/user_remote_data_source.dart';
import 'package:recipes_app/user/services/user_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../auth/data_sources/auth_remote_data_source.dart';
import '../../auth/services/auth_service.dart';
import 'package:recipes_app/network/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:recipes_app/recipes/blocs/recipe_cubit.dart';
import 'package:recipes_app/recipes/services/recipe_service.dart';

final getIt = GetIt.instance;

@InjectableInit(preferRelativeImports: false)
void configureDependencies() => getIt.init();



@module
abstract class RegisterModule {
  
  SupabaseClient get supabaseClient => Supabase.instance.client;

  @singleton
  AuthRemoteDataSource get authRemoteDataSource =>
      AuthRemoteDataSource(supabaseClient);

  @singleton
  UserRemoteDataSource get userRemoteDataSource =>
      UserRemoteDataSource(supabaseClient);

  @singleton
  RecipeRemoteDataSource get recipeRemoteDataSource =>
      RecipeRemoteDataSource(supabaseClient);

  @singleton
  AuthService get authService => AuthService(authRemoteDataSource);

  @singleton
  UserService get userService => UserService(userRemoteDataSource);

  @singleton
  RecipeService get recipeService => RecipeService(recipeRemoteDataSource);

  @singleton
  UserCubit get userCubit => UserCubit(userService);

  @singleton
  AuthCubit get authCubit => AuthCubit(authService, userCubit);

  @singleton
  RecipeCubit get recipeCubit => RecipeCubit(recipeService);

  @singleton
  Dio get dio => Dio();

  @singleton
  MealApiService get mealApiService => MealApiService(dio);
}

