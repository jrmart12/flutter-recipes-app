import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recipes_app/user/dtos/user_dto.dart';

part 'user_state.freezed.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = _Initial;
  const factory UserState.loading() = _Loading;
  const factory UserState.authenticated(UserDto user) = _Authenticated;
  const factory UserState.unauthenticated() = _Unauthenticated;
  const factory UserState.error(String message) = _Error;
}
