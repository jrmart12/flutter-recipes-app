import 'package:recipes_app/recipes/dtos/recipe_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_state.freezed.dart';

@freezed
class RecipeState with _$RecipeState {
  const factory RecipeState.initial() = _Initial;
  const factory RecipeState.loading() = _Loading;
  const factory RecipeState.loaded(List<RecipeDto> recipes) = _Loaded;
  const factory RecipeState.error(String message) = _Error;
}
