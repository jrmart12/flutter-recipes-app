import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:gotrue/src/types/user.dart' as User;
import 'package:recipes_app/auth/services/auth_service.dart';
import 'package:recipes_app/auth/business_objects/auth.failure.dart';
import 'package:recipes_app/user/blocs/user_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_state.dart' as AuthState;


class AuthCubit extends Cubit<AuthState.AuthState> {
  final AuthService _authService;
  final UserCubit _userCubit;

  AuthCubit(this._authService, this._userCubit)
      : super(const AuthState.AuthState.initial());

  get email => null;

  Future<void> signUp(String email, String password, String fullName) async {
    if (email == null || email.isEmpty) {
      emit(const AuthState.AuthState.error('Invalid email'));
      return;
    }
    emit(const AuthState.AuthState.loading());
    try {
      final result = await _authService.signUp(email, password);
      result.fold(
        (failure) => _handleSignUpError(failure),
        (_) {
          final user = Supabase.instance.client.auth.currentUser;
          if (user != null) {
            _userCubit.setUserInformation(fullName);
            emit(AuthState.AuthState.authenticated(user as User.User));
          } else {
            emit(const AuthState.AuthState.unauthenticated());
          }
        },
      );
    } on Object catch (error, stackTrace) {
      emit(AuthState.AuthState.error('An unexpected error occurred: $error'));
      print('$error\n$stackTrace');
    }
  }

  void _handleSignUpError(AuthFailure failure) {
    switch (failure) {
      case AuthFailure.serverError:
        emit(const AuthState.AuthState.error('Failed to sign up'));
        break;
      case AuthFailure.invalidEmail:
        emit(const AuthState.AuthState.error('Invalid email'));
        break;
      default:
        print('Unknown error occurred while signing up: $failure');
        emit(const AuthState.AuthState.error('Failed to sign up'));
    }
  }

Future<void> signIn(String email, String password) async {
    emit(const AuthState.AuthState.loading());
    try {
      final result = await _authService.signIn(email, password);
      result.fold(
        (failure) => emit(const AuthState.AuthState.error('Failed to sign in')),
        (_) {
          final user = Supabase.instance.client.auth.currentUser;
          if (user != null) {
            emit(AuthState.AuthState.authenticated(user as User.User));
          } else {
            emit(const AuthState.AuthState.unauthenticated());
          }
        },
      );
    } catch (e) {
      emit(const AuthState.AuthState.error('Failed to sign in'));
    }
  }

  Future<void> resetPassword(String email) async {
    emit(const AuthState.AuthState.loading());
    if (email == null || email.isEmpty) {
      emit(const AuthState.AuthState.error('Invalid email'));
      return;
    }

    try {
      final result = await _authService.resetPassword(email);
      print(result);
      result.fold(
        (failure) => _handleResetPasswordError(failure),
        (_) => emit(const AuthState.AuthState.unauthenticated()),
      );
    } on Object catch (error) {
      print('Error occurred while resetting password: $error');
      emit(const AuthState.AuthState.error('Failed to reset password'));
    }
  }

  void _handleResetPasswordError(AuthFailure failure) {
    switch (failure) {
      case AuthFailure.serverError:
        emit(const AuthState.AuthState.error('Failed to reset password'));
        break;
      case AuthFailure.invalidEmail:
        emit(const AuthState.AuthState.error('Invalid email'));
        break;
      default:
        print('Unknown error occurred while resetting password: $failure');
        emit(const AuthState.AuthState.error('Failed to reset password'));
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    emit(const AuthState.AuthState.unauthenticated());
  }

  void checkAuthStatus() {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      emit(AuthState.AuthState.authenticated(user as User.User));
    } else {
      emit(const AuthState.AuthState.unauthenticated());
    }
  }
}
