import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes_app/auth/blocs/auth_cubit.dart';
import 'package:recipes_app/core/di/injection.dart';
import 'package:recipes_app/network/retrofit.dart';
import 'package:recipes_app/router/app_router.dart';
import 'package:recipes_app/user/blocs/user_cubit.dart';
import 'package:recipes_app/user/blocs/user_state.dart';

@RoutePage()
class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final MealApiService _mealApiService = MealApiService(getIt());
  List<Meal> _favoriteMeals = [];

  @override
  void initState() {
    super.initState();
    _fetchFavoriteMeals();
  }

  Future<void> _fetchFavoriteMeals() async {
    final userCubit = context.read<UserCubit>();
    final state = userCubit.state;

    state.maybeWhen(
      authenticated: (userDto) async {
        final favoriteRecipes = userDto.favoriteRecipes ?? [];
        _updateFavoriteMeals(favoriteRecipes);
      },
      orElse: () {
        // Handle other states if needed
      },
    );
  }

  Future<void> _updateFavoriteMeals(List<String> favoriteRecipes) async {
    if (favoriteRecipes.isNotEmpty) {
      final meals = await Future.wait(
        favoriteRecipes.map(
          (id) => _mealApiService.getMealsById(id),
        ),
      );
      setState(() {
        _favoriteMeals = meals.expand((meal) => meal.meals).toList();
      });
    } else {
      setState(() {
        _favoriteMeals = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Favorites'),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: context.read<AuthCubit>(),
          ),
          BlocProvider.value(
            value: context.read<UserCubit>()
              ..getUserFavoriteRecipes()
              ..stream.listen((state) {
                state.maybeWhen(
                  favoriteRecipesUpdated: (favoriteRecipes) {
                    _updateFavoriteMeals(favoriteRecipes);
                  },
                  orElse: () {},
                );
              }),
          ),
        ],
        child: _favoriteMeals.isNotEmpty
            ? ListView.builder(
                itemCount: _favoriteMeals.length,
                itemBuilder: (context, index) {
                  final meal = _favoriteMeals[index];
                  return Card(
                    child: ListTile(
                      leading: Image.network(
                        meal.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(meal.name),
                      trailing: const Icon(Icons.favorite, color: Colors.red),
                      onTap: () {
                        context.router.push(MealDetailsRoute(mealId: meal.id));
                      },
                    ),
                  );
                },
              )
            : const Center(
                child: Text('No favorite recipes found.'),
              ),
      ),
    );
  }
}
