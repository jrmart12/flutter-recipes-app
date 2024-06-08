import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes_app/recipes/blocs/recipe_cubit.dart';
import 'package:recipes_app/recipes/blocs/recipe_state.dart';
import 'package:recipes_app/router/app_router.dart';

@RoutePage()
class RecipeDetailsPage extends StatelessWidget {
  final String recipeId;

  const RecipeDetailsPage({super.key, required this.recipeId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeCubit, RecipeState>(
      builder: (context, state) {
        return state.maybeWhen(
          loaded: (recipes) {
            final recipe =
                recipes.firstWhere((recipe) => recipe.recipeId == recipeId);
            return Scaffold(
              appBar: AppBar(
                title: Text(recipe.name),
                actions: [
                  IconButton(
                    onPressed: () {
                      context.router.push(
                        RecipeFormRoute(recipe: recipe),
                      );
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<RecipeCubit>().deleteRecipe(recipeId);
                      context.router.push(
                        const ProfileRoute(),
                      );
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          recipe!.imageUrl,
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Category: ${recipe.category}',
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Instructions',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    recipe!.instructions,
                                    style: const TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          const Text(
                            'Ingredients',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          ...recipe.ingredients.map(
                            (ingredient) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(
                                  '${recipe.ingredients.indexOf(ingredient) + 1}. $ingredient'),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Measurements',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...recipe.measurements.map(
                            (measurement) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(
                                  '${recipe.measurements.indexOf(measurement) + 1}. $measurement'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          orElse: () {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        );
      },
    );
  }
}
