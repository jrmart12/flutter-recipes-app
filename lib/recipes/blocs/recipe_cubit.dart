import 'package:bloc/bloc.dart';
import 'package:recipes_app/recipes/dtos/recipe_dto.dart';
import 'package:recipes_app/recipes/services/recipe_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  final RecipeService _recipeService;

  RecipeCubit(this._recipeService) : super(const RecipeState.initial());

  Future<void> fetchRecipes() async {
    emit(const RecipeState.loading());
    try {
      final recipes = await _recipeService.getRecipes();
      print('entro');
      emit(RecipeState.loaded(recipes));
    } catch (e) {
      emit(const RecipeState.error('Failed to fetch recipes'));
    }
  }

  Future<void> createRecipe(RecipeDto recipe) async {
    emit(const RecipeState.loading());
    try {
      await _recipeService.createRecipe(recipe);
      final recipes = await _recipeService.getRecipes();
      emit(RecipeState.loaded(recipes));
    } catch (e) {
      emit(const RecipeState.error('Failed to create recipe'));
    }
  }

  Future<void> updateRecipe(RecipeDto recipe, String? recipeId) async {
    emit(const RecipeState.loading());
    try {
      await _recipeService.updateRecipe(recipe, recipeId!);
      final recipes = await _recipeService.getRecipes();
      emit(RecipeState.loaded(recipes));
    } catch (e) {
      emit(const RecipeState.error('Failed to update recipe'));
    }
  }

  Future<void> deleteRecipe(String recipeId) async {
    emit(const RecipeState.loading());
    try {
      await _recipeService.deleteRecipe(recipeId);
      final recipes = await _recipeService.getRecipes();
      emit(RecipeState.loaded(recipes));
    } catch (e) {
      emit(const RecipeState.error('Failed to delete recipe'));
    }
  }
}
