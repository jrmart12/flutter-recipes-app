import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes_app/auth/blocs/auth_cubit.dart';
import 'package:recipes_app/core/di/injection.dart';
import 'package:recipes_app/network/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:recipes_app/user/blocs/user_cubit.dart';
import 'package:recipes_app/user/blocs/user_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

@RoutePage()
class MealDetailsPage extends StatefulWidget {
  final String mealId;

  const MealDetailsPage({Key? key, required this.mealId}) : super(key: key);

  @override
  _MealDetailsPageState createState() => _MealDetailsPageState();
}

class _MealDetailsPageState extends State<MealDetailsPage> {
  final MealApiService _mealApiService = MealApiService(Dio());
  Meal? _meal;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _fetchMealDetails();
  }

  Future<void> _fetchMealDetails() async {
    try {
      final mealsResponse = await _mealApiService.getMealsById(widget.mealId);
      setState(() {
        _meal = mealsResponse.meals.first;
      });
      // Check if the meal is in the favorite recipes list
      final userCubit = context.read<UserCubit>();
      final state = userCubit.state;
      state.maybeWhen(
        authenticated: (userDto) {
          final favoriteRecipes = userDto.favoriteRecipes ?? [];
          _isFavorite = favoriteRecipes.contains(widget.mealId);
        },
        orElse: () {
          // Handle other states if needed
        },
      );
    } catch (e) {
      // Handle error
      print('Error fetching meal details: $e');
    }
  }

  void _toggleFavorite(BuildContext context) {
    final userCubit = context.read<UserCubit>();
    final state = userCubit.state;

    state.maybeWhen(
      authenticated: (userDto) {
        final favoriteRecipes = userDto.favoriteRecipes ?? [];
        final mealId = widget.mealId;

        if (_isFavorite) {
          // Remove the meal from the favorite recipes list
          final updatedFavoriteRecipes =
              favoriteRecipes.where((id) => id != mealId).toList();
          userCubit.updateFavoriteRecipes(updatedFavoriteRecipes);
        } else {
          // Add the meal to the favorite recipes list
          final updatedFavoriteRecipes = [...favoriteRecipes, mealId];
          userCubit.updateFavoriteRecipes(updatedFavoriteRecipes);
        }

        setState(() {
          _isFavorite = !_isFavorite;
        });
      },
      orElse: () {
        // Handle other states if needed
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(_meal?.name ?? 'Meal Details'),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : null,
            ),
            onPressed: () {
              _toggleFavorite(context);
            },
          ),
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: context.read<AuthCubit>(),
          ),
          BlocProvider.value(
            value: context.read<UserCubit>()..getUserFavoriteRecipes(),
          ),
        ],
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            return _meal == null
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              _meal!.imageUrl,
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
                                'Category: ${_meal!.category}',
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      const Text(
                                        'Ingredients',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      if (_meal!.ingredient1 != null &&
                                          _meal!.ingredient1 != '')
                                        Text(
                                            ' ${_meal!.ingredient1} ${_meal!.measure1 != null && _meal!.measure1 != '' ? '(${_meal!.measure1})' : ''}'),
                                      if (_meal!.ingredient2 != null &&
                                          _meal!.ingredient2 != '')
                                        Text(
                                            ' ${_meal!.ingredient2} ${_meal!.measure2 != null && _meal!.measure2 != '' ? '(${_meal!.measure2})' : ''}'),
                                      if (_meal!.ingredient3 != null &&
                                          _meal!.ingredient3 != '')
                                        Text(
                                            ' ${_meal!.ingredient3} ${_meal!.measure3 != null && _meal!.measure3 != '' ? '(${_meal!.measure3})' : ''}'),
                                      if (_meal!.ingredient4 != null &&
                                          _meal!.ingredient4 != '')
                                        Text(
                                            ' ${_meal!.ingredient4} ${_meal!.measure4 != null && _meal!.measure4 != '' ? '(${_meal!.measure4})' : ''}'),
                                      if (_meal!.ingredient5 != null &&
                                          _meal!.ingredient5 != '')
                                        Text(
                                            ' ${_meal!.ingredient5} ${_meal!.measure5 != null && _meal!.measure5 != '' ? '(${_meal!.measure5})' : ''}'),
                                      if (_meal!.ingredient6 != null &&
                                          _meal!.ingredient6 != '')
                                        Text(
                                            ' ${_meal!.ingredient6} ${_meal!.measure6 != null && _meal!.measure6 != '' ? '(${_meal!.measure6})' : ''}'),
                                      if (_meal!.ingredient7 != null &&
                                          _meal!.ingredient7 != '')
                                        Text(
                                            ' ${_meal!.ingredient7} ${_meal!.measure7 != null && _meal!.measure7 != '' ? '(${_meal!.measure7})' : ''}'),
                                      if (_meal!.ingredient8 != null &&
                                          _meal!.ingredient8 != '')
                                        Text(
                                            ' ${_meal!.ingredient8} ${_meal!.measure8 != null && _meal!.measure8 != '' ? '(${_meal!.measure8})' : ''}'),
                                      if (_meal!.ingredient9 != null &&
                                          _meal!.ingredient9 != '')
                                        Text(
                                            ' ${_meal!.ingredient9} ${_meal!.measure9 != null && _meal!.measure9 != '' ? '(${_meal!.measure9})' : ''}'),
                                      if (_meal!.ingredient10 != null &&
                                          _meal!.ingredient10 != '')
                                        Text(
                                            ' ${_meal!.ingredient10} ${_meal!.measure10 != null && _meal!.measure10 != '' ? '(${_meal!.measure10})' : ''}'),
                                      if (_meal!.ingredient11 != null &&
                                          _meal!.ingredient11 != '')
                                        Text(
                                            ' ${_meal!.ingredient11} ${_meal!.measure11 != null && _meal!.measure11 != '' ? '(${_meal!.measure11})' : ''}'),
                                      if (_meal!.ingredient12 != null &&
                                          _meal!.ingredient12 != '')
                                        Text(
                                            ' ${_meal!.ingredient12} ${_meal!.measure12 != null && _meal!.measure12 != '' ? '(${_meal!.measure12})' : ''}'),
                                      if (_meal!.ingredient13 != null &&
                                          _meal!.ingredient13 != '')
                                        Text(
                                            ' ${_meal!.ingredient13} ${_meal!.measure13 != null && _meal!.measure13 != '' ? '(${_meal!.measure13})' : ''}'),
                                      if (_meal!.ingredient14 != null &&
                                          _meal!.ingredient14 != '')
                                        Text(
                                            ' ${_meal!.ingredient14} ${_meal!.measure14 != null && _meal!.measure14 != '' ? '(${_meal!.measure14})' : ''}'),
                                      if (_meal!.ingredient15 != null &&
                                          _meal!.ingredient15 != '')
                                        Text(
                                            ' ${_meal!.ingredient15} ${_meal!.measure15 != null && _meal!.measure15 != '' ? '(${_meal!.measure15})' : ''}'),
                                      if (_meal!.ingredient16 != null &&
                                          _meal!.ingredient16 != '')
                                        Text(
                                            ' ${_meal!.ingredient16} ${_meal!.measure16 != null && _meal!.measure16 != '' ? '(${_meal!.measure16})' : ''}'),
                                      if (_meal!.ingredient17 != null &&
                                          _meal!.ingredient17 != '')
                                        Text(
                                            ' ${_meal!.ingredient17} ${_meal!.measure17 != null && _meal!.measure17 != '' ? '(${_meal!.measure17})' : ''}'),
                                      if (_meal!.ingredient18 != null &&
                                          _meal!.ingredient18 != '')
                                        Text(
                                            ' ${_meal!.ingredient18} ${_meal!.measure18 != null && _meal!.measure18 != '' ? '(${_meal!.measure18})' : ''}'),
                                      if (_meal!.ingredient19 != null &&
                                          _meal!.ingredient19 != '')
                                        Text(
                                            ' ${_meal!.ingredient19} ${_meal!.measure19 != null && _meal!.measure19 != '' ? '(${_meal!.measure19})' : ''}'),
                                      if (_meal!.ingredient20 != null &&
                                          _meal!.ingredient20 != '')
                                        Text(
                                            ' ${_meal!.ingredient20} ${_meal!.measure20 != null && _meal!.measure20 != '' ? '(${_meal!.measure20})' : ''}'),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              _meal!.videoUrl != ''
                                  ? YoutubePlayer(
                                      controller: YoutubePlayerController(
                                        initialVideoId:
                                            YoutubePlayer.convertUrlToId(
                                                    _meal!.videoUrl) ??
                                                '',
                                        flags: const YoutubePlayerFlags(
                                          autoPlay: false,
                                          mute: false,
                                        ),
                                      ),
                                      showVideoProgressIndicator: true,
                                      progressIndicatorColor: Colors.amber,
                                    )
                                  : const SizedBox.shrink(),
                              const SizedBox(height: 16.0),
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        _meal!.instructions,
                                        style: const TextStyle(fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
