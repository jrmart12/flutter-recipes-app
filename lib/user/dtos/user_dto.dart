import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gotrue/src/types/user.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    required String id,
    required String email,
    required String? fullName,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'email': email,
        'fullName': fullName,
      };
}
