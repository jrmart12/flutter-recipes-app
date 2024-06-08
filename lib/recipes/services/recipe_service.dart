import 'package:recipes_app/recipes/data_sources/recipe_remote_data_source.dart';
import 'package:recipes_app/recipes/dtos/recipe_dto.dart';

class RecipeService {
  final RecipeRemoteDataSource _remoteDataSource;

  RecipeService(this._remoteDataSource);

  Future<List<RecipeDto>> getRecipes() async {
    return _remoteDataSource.getRecipes();
  }

  Future<void> createRecipe(RecipeDto recipe) async {
    return _remoteDataSource.createRecipe(recipe);
  }

  Future<void> updateRecipe(RecipeDto recipe, String recipeId) async {
    return _remoteDataSource.updateRecipe(recipe, recipeId);
  }

  Future<void> deleteRecipe(String recipeId) async {
    return _remoteDataSource.deleteRecipe(recipeId);
  }
}
