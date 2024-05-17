import 'package:recipes_app/auth/models/user.dart';
import 'package:recipes_app/core/errors/auth_failure.dart';

class AuthService {
  Future<User> signIn(String email, String password) async {
    // Example: Implement sign-in logic
    throw AuthFailure('Sign-in failed');
  }

  Future<User> signUp(String email, String password) async {
    // Example: Implement sign-up logic
    throw AuthFailure('Sign-up failed');
  }

  Future<void> forgotPassword(String email) async {
    // Example: Implement forgot password logic
    throw AuthFailure('Forgot password failed');
  }
}