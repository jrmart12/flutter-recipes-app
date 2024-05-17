import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:recipes_app/data/models/models.dart';
part 'recipe_api_service.g.dart';

@RestApi(baseUrl: 'https://api.example.com')
abstract class RecipeApiService {
  factory RecipeApiService(Dio dio, {String baseUrl}) = _RecipeApiService;

  @GET('/recipes')
  Future<List<Recipe>> getRecipes();
}