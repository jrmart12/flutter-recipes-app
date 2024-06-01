import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:recipes_app/network/retrofit.dart';
import 'package:recipes_app/router/app_router.dart';
// Import your API service

@RoutePage()
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final MealApiService _mealApiService = MealApiService(Dio());
  final TextEditingController _searchController = TextEditingController();
  List<Meal> _searchResults = [];
  bool _isLoading = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search for a recipe',
                prefixIcon: Icon(Icons.search),
              ),
              onSubmitted: (query) async {
                setState(() {
                  _searchResults = [];
                  _isLoading = true;
                });

                try {
                  final response = await _mealApiService.getMealsByName(query);
                  setState(() {
                    _searchResults = response.meals;
                    _isLoading = false;
                  });
                } catch (e) {
                  print('Error fetching recipes: $e');
                }
              },
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(
                    child:
                        CircularProgressIndicator()) // Show loader when loading
                : FutureBuilder<List<Meal>>(
                    future: Future.value(_searchResults),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.data!.isEmpty) {
                        return const Center(child: Text('No results found'));
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final meal = snapshot.data![index];
                            return GestureDetector(
                              onTap: () {
                                context.router.push(
                                  MealDetailsRoute(mealId: meal.id),
                                );
                              },
                              child: Card(
                                child: ListTile(
                                  leading: Image.network(meal.imageUrl),
                                  title: Text(meal.name),
                                  subtitle: Text(meal.category),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
