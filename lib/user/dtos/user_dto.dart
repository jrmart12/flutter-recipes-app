import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gotrue/src/types/user.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    required String userId,
    required String email,
    required String? fullName,
      required String? createdAt
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'userId': userId,
        'email': email,
        'fullName': fullName,
        'createdAt': createdAt
      };
}
