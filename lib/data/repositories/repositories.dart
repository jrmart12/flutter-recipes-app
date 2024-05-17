import 'package:recipes_app/data/models/models.dart';

abstract class RecipeRepository {
  Future<List<Recipe>> getRecipes();
}