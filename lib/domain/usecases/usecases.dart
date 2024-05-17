import 'package:recipes_app/core/errors/errors.dart';
import 'package:recipes_app/domain/repositories/repositories.dart';
import 'package:recipes_app/domain/models/models.dart';

class UserRecipeUseCase {
  final UserRecipeRepository _repository;

  UserRecipeUseCase(this._repository);

  Future<List<UserRecipe>> getUserRecipes() async {
    try {
      return await _repository.getUserRecipes();
    } catch (e) {
      throw AuthFailure();
    }
  }

  // Implement other use cases
}