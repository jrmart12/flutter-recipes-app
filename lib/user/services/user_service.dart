import 'package:dartz/dartz.dart';
import 'package:recipes_app/user/business_objects/user.failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data_sources/user_remote_data_source.dart';
import '../dtos/user_dto.dart';

class UserService {
  final UserRemoteDataSource _remoteDataSource;

  UserService(this._remoteDataSource);

  Future<Either<UserFailure, UserDto>?> getUserInfo(String userId) async {
    return await _remoteDataSource.getUserInformation(userId);
  }

  Future<Either<UserFailure, UserDto>?> setUserInfo(
      String userId, String email, String fullName, String createdAt) async {
    return await _remoteDataSource.setUserInformation(
        userId, email, fullName, createdAt);
  }

  Future<Either<UserFailure, Unit>?> updateFavoriteRecipes(
      String userId, List<String> favoriteRecipes) async {
    return await _remoteDataSource.updateFavoriteRecipes(
        userId, favoriteRecipes);
  }

  Future<Either<UserFailure, UserDto>?> getUserFavoriteRecipes(
      String userId) async {
    return await _remoteDataSource.getUserFavoriteRecipes(userId);
  }

  
}
