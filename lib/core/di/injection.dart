import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:recipes_app/auth/blocs/auth_cubit.dart';
import 'package:recipes_app/core/di/injection.config.dart';
import 'package:recipes_app/user/blocs/user_cubit.dart';
import 'package:recipes_app/user/data_sources/user_remote_data_source.dart';
import 'package:recipes_app/user/services/user_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../auth/data_sources/auth_remote_data_source.dart';
import '../../auth/services/auth_service.dart';

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
  AuthService get authService => AuthService(authRemoteDataSource);

  @singleton
  UserService get userService => UserService(userRemoteDataSource);

  @singleton
  AuthCubit get authCubit => AuthCubit(getIt<AuthService>());

  @singleton
  UserCubit get userCubit => UserCubit(getIt<UserService>());
}
