import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:recipes_app/recipes/dtos/recipe_dto.dart';

class RecipeRemoteDataSource {
  final SupabaseClient _supabaseClient;

  RecipeRemoteDataSource(this._supabaseClient);

  Future<List<RecipeDto>> getRecipes() async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      print(userId);
      final data =
          await _supabaseClient.from('recipes').select().eq('userId', userId!);
      print('recipes $data');
      print(data.map((json) => RecipeDto.fromJson(json)).toList());
      return data.map((json) => RecipeDto.fromJson(json)).toList();
    } on PostgrestException catch (e) {
      // Handle Supabase error
      print('Error fetching recipes: ${e.message}');
      return [];
    } catch (e) {
      // Handle other exceptions
      print('Error fetching recipes: $e');
      return [];
    }
  }

  Future<void> createRecipe(RecipeDto recipe) async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      print(userId);
      final recipeData = recipe.toJson();
      recipeData.remove('recipeId');
      final data = {
        ...recipeData,
        'userId': userId,
      };
      print(data);
      await _supabaseClient.from('recipes').insert(data);
    } on PostgrestException catch (e) {
      // Handle Supabase error
      print('Error creating recipe: ${e.message}');
    } catch (e) {
      // Handle other exceptions
      print('Error creating recipe: $e');
    }
  }

  Future<void> updateRecipe(RecipeDto recipe, String recipeId) async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      final recipeData = recipe.toJson();
      final data = {
        ...recipeData,
        'userId': userId,
      };
      await _supabaseClient
          .from('recipes')
          .update(data)
          .eq('recipeId', recipeId);
    } on PostgrestException catch (e) {
      // Handle Supabase error
      print('Error updating recipe: ${e.message}');
    } catch (e) {
      // Handle other exceptions
      print('Error updating recipe: $e');
    }
  }

  Future<void> deleteRecipe(String recipeId) async {
    try {
      await _supabaseClient.from('recipes').delete().eq('recipeId', recipeId);
    } on PostgrestException catch (e) {
      // Handle Supabase error
      print('Error deleting recipe: ${e.message}');
    } catch (e) {
      // Handle other exceptions
      print('Error deleting recipe: $e');
    }
  }
}
