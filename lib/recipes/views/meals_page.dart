import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:recipes_app/network/retrofit.dart';
import 'package:recipes_app/router/app_router.dart';

@RoutePage()
class MealsPage extends StatefulWidget {
  final String categoryName;
  final String categoryId;

  const MealsPage({
    Key? key,
    required this.categoryName,
    required this.categoryId,
  }) : super(key: key);

  @override
  _MealsPageState createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  final MealApiService _mealApiService = MealApiService(Dio());
  List<MealCategory> _meals = [];

  @override
  void initState() {
    super.initState();
    _fetchMeals();
  }

  Future<void> _fetchMeals() async {
    try {
      final mealsCategoryResponse =
          await _mealApiService.getMealsByCategory(widget.categoryName);
      setState(() {
        _meals = mealsCategoryResponse.meals;
      });
    } catch (e) {
      // Handle error
      print('Error fetching meals: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.categoryName),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: _meals.isNotEmpty
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                ),
                itemCount: _meals.length,
                itemBuilder: (context, index) {
                  final meal = _meals[index];
                  return GestureDetector(
                    onTap: () {
                      context.router.push(
                        MealDetailsRoute(mealId: meal.mealId),
                      );
                    },
                    child: Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            ),
                          ),
                          Container(
                            height: 40,
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              meal.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
