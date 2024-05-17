import 'package:recipes_app/data/models/models.dart';

abstract class RecipeDataSource {
  Future<List<Recipe>> fetchRecipes();
}