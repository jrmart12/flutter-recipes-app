import 'package:dartz/dartz.dart';
import 'package:recipes_app/user/business_objects/user.failure.dart';
import 'package:recipes_app/user/dtos/user_dto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRemoteDataSource {
  final SupabaseClient _client;

  UserRemoteDataSource(this._client);

  Future<Either<UserFailure, UserDto>?> getUserInformation(
      String userId) async {
    try {
      final data =
          await _client.from('users').select().eq('userId', userId).single();
      print(data);
      if (data == null) {
        return left(UserFailure.userNotFound);
      }
print('user info $data');
      final userDto = UserDto.fromJson(data);

      return right(userDto);
    } on Object catch (error, stackTrace) {
      print('Error occurred while fetching user info: $error\n$stackTrace');

      return left(UserFailure.serverError);
    }
  }

  Future<Either<UserFailure, UserDto>?> setUserInformation(
      String userId, String email, String fullName, String createdAt) async {
    try {
      // Create a new user record in the 'users' table

      final userData = UserDto(
          userId: userId,
          fullName: fullName,
          email: email,
          createdAt: createdAt);

      final data = await _client.from('users').insert(userData.toJson());
  
      final userDto = UserDto.fromJson(data);

      return right(userDto);
    } on Object catch (error, stackTrace) {


      return left(UserFailure.serverError);
    }
  }
}
