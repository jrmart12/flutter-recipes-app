import 'package:recipes_app/auth/models/user.dart';

abstract class AuthRepository {
  Future<User> signIn(String email, String password);
  Future<void> signUp(String email, String password);
  Future<void> forgotPassword(String email);
}