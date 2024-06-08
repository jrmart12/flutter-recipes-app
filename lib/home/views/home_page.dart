import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes_app/auth/blocs/auth_cubit.dart';
import 'package:recipes_app/auth/blocs/auth_state.dart';
import 'package:recipes_app/network/retrofit.dart';
import 'package:recipes_app/router/app_router.dart';
import 'package:recipes_app/user/blocs/user_cubit.dart';
import 'package:recipes_app/user/blocs/user_state.dart';
import 'package:gotrue/src/types/user.dart';
import 'package:recipes_app/widgets/user_information_text.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MealApiService _mealApiService = MealApiService(Dio());
  List<Category> _categories = [];
  List<Meal> _favoriteMeals = [];
  bool _favoriteMealsFetched = false;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final categoriesResponse = await _mealApiService.getCategories();
      setState(() {
        _categories = categoriesResponse.categories;
      });
    } catch (e) {
      // Handle error
      print('Error fetching categories: $e');
    }
  }

  Future<void> _fetchFavoriteMeals() async {
    final userCubit = context.read<UserCubit>();
    final state = userCubit.state;
    print(state);
    state.maybeWhen(
      authenticated: (userDto) async {
        print(userDto.favoriteRecipes);
        final favoriteRecipes = userDto.favoriteRecipes ?? [];
        _updateFavoriteMeals(favoriteRecipes);
      },
      orElse: () {
        // Handle other states if needed
      },
    );
  }

  Future<void> _updateFavoriteMeals(List<String> favoriteRecipes) async {
    try {
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
    } on DioException catch (e) {
      // Handle the DioException here
      print('Error fetching favorite meals: $e');
      // Show an error message or retry the request after a delay
    } catch (e) {
      // Handle other exceptions
      print('Error fetching favorite meals: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: context.read<AuthCubit>(),
          ),
          BlocProvider.value(
            value: context.read<UserCubit>()
              ..getUserInformation()
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
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            return state.maybeWhen(
              authenticated: (user) {
                if (_categories.isEmpty || !_favoriteMealsFetched) {
                  if (!_favoriteMealsFetched) {
                    _fetchFavoriteMeals();
                    _favoriteMealsFetched = true;
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                
                return SafeArea(
                  top: true,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(height: 16),
                        UserInformationText(userId: user.userId),
                        const SizedBox(height: 16),
                        const Text(
                          'What will we cook today?',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Categories',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.router.push(CategoriesRoute());
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black,
                              ),
                              child: const Text('See All',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        CarouselSlider(
                          items: _categories.map((category) {
                            return GestureDetector(
                              onTap: () {
                                context.router.push(
                                  MealsRoute(
                                      categoryId: category.id,
                                      categoryName: category.name),
                                );
                              },
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8.0),
                                          topRight: Radius.circular(8.0),
                                        ),
                                        child: Image.network(
                                          category.imageUrl ?? '',
                                          fit: BoxFit.cover,
                                          height: 120,
                                          width: double.infinity,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        category.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          options: CarouselOptions(
                            height: 200,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: false,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Favorites',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.router.push(FavoritesRoute());
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black,
                              ),
                              child: const Text('See All',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        CarouselSlider(
                          items: _favoriteMeals.map((meal) {
                            return GestureDetector(
                                onTap: () {
                                  context.router.push(
                                    MealDetailsRoute(mealId: meal.id),
                                  );
                                },
                                child: Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                  
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8.0),
                                            topRight: Radius.circular(8.0),
                                          ),
                                          child: Image.network(
                                            meal.imageUrl ?? '',
                                            fit: BoxFit.cover,
                                            height: 120,
                                            width: double.infinity,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          meal.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                          }).toList(),
                          options: CarouselOptions(
                            height: 200,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              orElse: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          },
        ),
      ),
      ),
    );
  }
}
