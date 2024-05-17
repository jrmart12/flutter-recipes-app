
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes_app/domain/usecases/usecases.dart';
import 'package:recipes_app/domain/models/models.dart';

class UserRecipeCubit extends Cubit<List<UserRecipe>> {
  final UserRecipeUseCase _useCase;

  UserRecipeCubit(this._useCase) : super([]);

  void fetchUserRecipes() async {
    final recipes = await _useCase.getUserRecipes();
    emit(recipes);
  }

  // Implement other cubit logic
}