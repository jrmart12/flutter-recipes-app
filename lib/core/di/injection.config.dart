// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:recipes_app/auth/blocs/auth_cubit.dart' as _i9;
import 'package:recipes_app/auth/data_sources/auth_remote_data_source.dart'
    as _i4;
import 'package:recipes_app/auth/services/auth_service.dart' as _i6;
import 'package:recipes_app/core/di/injection.dart' as _i12;
import 'package:recipes_app/network/retrofit.dart' as _i11;
import 'package:recipes_app/user/blocs/user_cubit.dart' as _i8;
import 'package:recipes_app/user/data_sources/user_remote_data_source.dart'
    as _i5;
import 'package:recipes_app/user/services/user_service.dart' as _i7;
import 'package:supabase_flutter/supabase_flutter.dart' as _i3;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factory<_i3.SupabaseClient>(() => registerModule.supabaseClient);
    gh.singleton<_i4.AuthRemoteDataSource>(
        () => registerModule.authRemoteDataSource);
    gh.singleton<_i5.UserRemoteDataSource>(
        () => registerModule.userRemoteDataSource);
    gh.singleton<_i6.AuthService>(() => registerModule.authService);
    gh.singleton<_i7.UserService>(() => registerModule.userService);
    gh.singleton<_i8.UserCubit>(() => registerModule.userCubit);
    gh.singleton<_i9.AuthCubit>(() => registerModule.authCubit);
    gh.singleton<_i10.Dio>(() => registerModule.dio);
    gh.singleton<_i11.MealApiService>(() => registerModule.mealApiService);
    return this;
  }
}

class _$RegisterModule extends _i12.RegisterModule {}
