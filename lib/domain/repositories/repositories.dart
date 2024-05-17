// import 'package:recipes_app/core/errors/errors.dart';
import 'package:recipes_app/domain/models/models.dart';

abstract class UserRecipeRepository {
  Future<List<UserRecipe>> getUserRecipes();
  Future<void> addUserRecipe(UserRecipe recipe);
  Future<void> updateUserRecipe(UserRecipe recipe);
  Future<void> deleteUserRecipe(String id);
}