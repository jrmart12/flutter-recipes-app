import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gotrue/src/types/user.dart' as User;

part 'user_state.freezed.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = _Initial;
  const factory UserState.loading() = _Loading;
  const factory UserState.authenticated(User.User user) = _Authenticated;
  const factory UserState.unauthenticated() = _Unauthenticated;
  const factory UserState.error(String message) = _Error;
}
