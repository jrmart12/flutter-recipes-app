import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_dto.freezed.dart';
part 'recipe_dto.g.dart';

@freezed
class RecipeDto with _$RecipeDto {
  const factory RecipeDto({
    String? recipeId,
    required String name,
    required String category,
    required String imageUrl,
    required String instructions,
    required List<String> ingredients,
    required List<String> measurements,
    String? userId,
  }) = _RecipeDto;

  factory RecipeDto.fromJson(Map<String, dynamic> json) =>
      _$RecipeDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'recipeId': recipeId,
        'name': name,
        'category': category,
        'imageUrl': imageUrl,
        'instructions': instructions,
        'ingredients': ingredients,
        'measurements': measurements,
        'userId': userId,
      };
}
