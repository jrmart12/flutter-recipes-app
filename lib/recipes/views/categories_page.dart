import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:recipes_app/network/retrofit.dart';
import 'package:get_it/get_it.dart';
import 'package:recipes_app/recipes/views/meals_page.dart';
import 'package:recipes_app/router/app_router.dart';

@RoutePage()
class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final MealApiService _mealApiService = MealApiService(Dio());
  List<Category> _categories = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Categories'),
      ),
      body: _categories.isNotEmpty
          ? ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                return Container(
                  margin: const EdgeInsets.only(
                      bottom: 20.0, left: 15.0, right: 15.0, top: 15),
                  child: GestureDetector(
                    onTap: () {
                      context.router.push(
                        MealsRoute(
                          categoryName: category.name,
                          categoryId: category.id,
                        ),
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
                          Image.network(
                            category.imageUrl ?? '',
                            fit: BoxFit.cover,
                            height: 140,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  category.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  category.description ?? '',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
