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
          await _client.from('users').select().eq('id', userId).single();

      if (data == null) {
        return left(UserFailure.userNotFound);
      }

      final userDto = UserDto.fromJson(data);

      return right(userDto);
    } on Object catch (error, stackTrace) {
      print('Error occurred while fetching user info: $error\n$stackTrace');

      return left(UserFailure.serverError);
    }
  }
}
