import 'package:dartz/dartz.dart';
import '../business_objects/auth.failure.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../../user/dtos/user_dto.dart';

class AuthService {
  final AuthRemoteDataSource _remoteDataSource;

  AuthService(this._remoteDataSource);

  Future<Either<AuthFailure, Unit>> signUp(
      String email, String password) async {
    try {
      await _remoteDataSource.signUp(email, password);
      return right(unit);
    } catch (_) {
      return left(AuthFailure.serverError);
    }
  }

  Future<Either<AuthFailure, Unit>> signIn(
      String email, String password) async {
    try {
      await _remoteDataSource.signIn(email, password);
      return right(unit);
    } catch (_) {
      return left(AuthFailure.invalidEmailPasswordCombination);
    }
  }

  Future<Either<AuthFailure, Unit>> resetPassword(String email) async {
    try {
      await _remoteDataSource.resetPassword(email);
      return right(unit);
    } catch (_) {
      return left(AuthFailure.serverError);
    }
  }

  Future<void> signOut() async {
    await _remoteDataSource.signOut();
  }
}