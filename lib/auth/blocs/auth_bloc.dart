
import 'package:bloc/bloc.dart';
import 'package:recipes_app/auth/models/user.dart';
import 'package:recipes_app/auth/services/auth_service.dart';
import 'package:recipes_app/core/errors/auth_failure.dart';
import 'auth_state.dart';

class AuthBloc extends Cubit<AuthState> {
  final AuthService _authService;

  AuthBloc(this._authService) : super(AuthState.initial());

  Future<void> signIn(String email, String password) async {
    emit(AuthState.loading());
    try {
      final user = await _authService.signIn(email, password);
      emit(AuthState.authenticated(user));
    } on AuthFailure catch (e) {
      emit(AuthState.error(e.message));
    }
  }

  Future<void> signUp(String email, String password) async {
    emit(AuthState.loading());
    try {
      final user = await _authService.signUp(email, password);
      emit(AuthState.authenticated(user));
    } on AuthFailure catch (e) {
      emit(AuthState.error(e.message));
    }
  }

  Future<void> forgotPassword(String email) async {
    emit(AuthState.loading());
    try {
      await _authService.forgotPassword(email);
      emit(AuthState.forgotPasswordSuccess());
    } on AuthFailure catch (e) {
      emit(AuthState.error(e.message));
    }
  }
}
