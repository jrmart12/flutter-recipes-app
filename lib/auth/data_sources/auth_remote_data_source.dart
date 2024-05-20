import 'package:supabase_flutter/supabase_flutter.dart';
import '../../user/dtos/user_dto.dart';
import 'package:dartz/dartz.dart';
import '../business_objects/auth.failure.dart';

class AuthRemoteDataSource {
  final SupabaseClient _supabaseClient;

  AuthRemoteDataSource(this._supabaseClient);

  Future<Either<AuthFailure, AuthResponse>?> signUp(
      String email, String password) async {
    await _supabaseClient.auth
        .signUp(email: email, password: password)
        .then((value) {
      return right(value);
    }).catchError((error) {
      // ignore: invalid_return_type_for_catch_error
      return left(AuthFailure.serverError);
    });
  }

  Future<Either<AuthFailure, AuthResponse>?> signIn(
      String email, String password) async {
    await _supabaseClient.auth
        .signInWithPassword(email: email, password: password)
        .then((value) {
      return right(value);
    }).catchError((error) {
      // ignore: invalid_return_type_for_catch_error
      return left(AuthFailure.serverError);
    });
  }

  Future<Either<AuthFailure, Unit>?> resetPassword(String email) async {
    await _supabaseClient.auth.resetPasswordForEmail(email).then((value) {
      return right(value);
    }).catchError((error) {
      // ignore: invalid_return_type_for_catch_error
      return left(AuthFailure.serverError);
    });
  }

  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }
}
