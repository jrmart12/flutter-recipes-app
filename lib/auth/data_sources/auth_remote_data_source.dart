import 'package:supabase_flutter/supabase_flutter.dart';
import '../../user/dtos/user_dto.dart';
import 'package:dartz/dartz.dart';
import '../business_objects/auth.failure.dart';

class AuthRemoteDataSource {
  final SupabaseClient _supabaseClient;

  AuthRemoteDataSource(this._supabaseClient);

  Future<Either<AuthFailure, AuthResponse>?> signUp(
      String email, String password) async {
    try {
      final response = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
      );
      return right(response);
    } catch (error) {
      return left(AuthFailure.serverError);
    }
  }

  Future<Either<AuthFailure, AuthResponse>?> signIn(
      String email, String password) async {

    try {
      final response = await _supabaseClient.auth
          .signInWithPassword(email: email, password: password);
      return right(response);
    } catch (error) {
      return left(AuthFailure.serverError);
    }
  }

  Future<Either<AuthFailure, Unit>> resetPassword(String email) async {
    try {
      await _supabaseClient.auth.resetPasswordForEmail(email);
      return right(unit);
    } catch (error) {
      return left(AuthFailure.serverError);
    }
  }

  Future<void> signOut() async {
    try {
      await _supabaseClient.auth.signOut();
    } on Object catch (error, stackTrace) {
      print(
        'Error occurred while signing out: $error\n$stackTrace',
      );
      rethrow;
    }
  }
}
