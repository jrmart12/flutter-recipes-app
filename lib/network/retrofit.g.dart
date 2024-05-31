// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retrofit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesResponse _$CategoriesResponseFromJson(Map<String, dynamic> json) =>
    CategoriesResponse(
      (json['categories'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoriesResponseToJson(CategoriesResponse instance) =>
    <String, dynamic>{
      'categories': instance.categories,
    };

MealsResponse _$MealsResponseFromJson(Map<String, dynamic> json) =>
    MealsResponse(
      (json['meals'] as List<dynamic>)
          .map((e) => Meal.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MealsResponseToJson(MealsResponse instance) =>
    <String, dynamic>{
      'meals': instance.meals,
    };

MealsCategoryResponse _$MealsCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    MealsCategoryResponse(
      (json['meals'] as List<dynamic>)
          .map((e) => MealCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MealsCategoryResponseToJson(
        MealsCategoryResponse instance) =>
    <String, dynamic>{
      'meals': instance.meals,
    };

MealCategory _$MealCategoryFromJson(Map<String, dynamic> json) => MealCategory(
      json['strMeal'] as String,
      json['idMeal'] as String,
      json['strMealThumb'] as String,
    );

Map<String, dynamic> _$MealCategoryToJson(MealCategory instance) =>
    <String, dynamic>{
      'strMeal': instance.name,
      'strMealThumb': instance.imageUrl,
      'idMeal': instance.mealId,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      json['strCategory'] as String,
      json['idCategory'] as String,
      json['strCategoryThumb'] as String,
      json['strCategoryDescription'] as String,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'idCategory': instance.id,
      'strCategory': instance.name,
      'strCategoryThumb': instance.imageUrl,
      'strCategoryDescription': instance.description,
    };

Meal _$MealFromJson(Map<String, dynamic> json) => Meal(
      json['idMeal'] as String,
      json['strMeal'] as String,
      json['strCategory'] as String,
      json['strInstructions'] as String,
      json['strYoutube'] as String,
      json['strMealThumb'] as String,
      json['strIngredient1'] as String?,
      json['strIngredient2'] as String?,
      json['strIngredient3'] as String?,
      json['strIngredient4'] as String?,
      json['strIngredient5'] as String?,
      json['strIngredient6'] as String?,
      json['strIngredient7'] as String?,
      json['strIngredient8'] as String?,
      json['strIngredient9'] as String?,
      json['strIngredient10'] as String?,
      json['strIngredient11'] as String?,
      json['strIngredient12'] as String?,
      json['strIngredient13'] as String?,
      json['strIngredient14'] as String?,
      json['strIngredient15'] as String?,
      json['strIngredient16'] as String?,
      json['strIngredient17'] as String?,
      json['strIngredient18'] as String?,
      json['strIngredient19'] as String?,
      json['strIngredient20'] as String?,
      json['strMeasure1'] as String?,
      json['strMeasure2'] as String?,
      json['strMeasure3'] as String?,
      json['strMeasure4'] as String?,
      json['strMeasure5'] as String?,
      json['strMeasure6'] as String?,
      json['strMeasure7'] as String?,
      json['strMeasure8'] as String?,
      json['strMeasure9'] as String?,
      json['strMeasure10'] as String?,
      json['strMeasure11'] as String?,
      json['strMeasure12'] as String?,
      json['strMeasure13'] as String?,
      json['strMeasure14'] as String?,
      json['strMeasure15'] as String?,
      json['strMeasure16'] as String?,
      json['strMeasure17'] as String?,
      json['strMeasure18'] as String?,
      json['strMeasure19'] as String?,
      json['strMeasure20'] as String?,
    );

Map<String, dynamic> _$MealToJson(Meal instance) => <String, dynamic>{
      'idMeal': instance.id,
      'strMeal': instance.name,
      'strCategory': instance.category,
      'strInstructions': instance.instructions,
      'strYoutube': instance.videoUrl,
      'strMealThumb': instance.imageUrl,
      'strIngredient1': instance.ingredient1,
      'strIngredient2': instance.ingredient2,
      'strIngredient3': instance.ingredient3,
      'strIngredient4': instance.ingredient4,
      'strIngredient5': instance.ingredient5,
      'strIngredient6': instance.ingredient6,
      'strIngredient7': instance.ingredient7,
      'strIngredient8': instance.ingredient8,
      'strIngredient9': instance.ingredient9,
      'strIngredient10': instance.ingredient10,
      'strIngredient11': instance.ingredient11,
      'strIngredient12': instance.ingredient12,
      'strIngredient13': instance.ingredient13,
      'strIngredient14': instance.ingredient14,
      'strIngredient15': instance.ingredient15,
      'strIngredient16': instance.ingredient16,
      'strIngredient17': instance.ingredient17,
      'strIngredient18': instance.ingredient18,
      'strIngredient19': instance.ingredient19,
      'strIngredient20': instance.ingredient20,
      'strMeasure1': instance.measure1,
      'strMeasure2': instance.measure2,
      'strMeasure3': instance.measure3,
      'strMeasure4': instance.measure4,
      'strMeasure5': instance.measure5,
      'strMeasure6': instance.measure6,
      'strMeasure7': instance.measure7,
      'strMeasure8': instance.measure8,
      'strMeasure9': instance.measure9,
      'strMeasure10': instance.measure10,
      'strMeasure11': instance.measure11,
      'strMeasure12': instance.measure12,
      'strMeasure13': instance.measure13,
      'strMeasure14': instance.measure14,
      'strMeasure15': instance.measure15,
      'strMeasure16': instance.measure16,
      'strMeasure17': instance.measure17,
      'strMeasure18': instance.measure18,
      'strMeasure19': instance.measure19,
      'strMeasure20': instance.measure20,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _MealApiService implements MealApiService {
  _MealApiService(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://www.themealdb.com/api/json/v1/1/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<CategoriesResponse> getCategories() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<CategoriesResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'categories.php',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = CategoriesResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MealsCategoryResponse> getMealsByCategory(String category) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'c': category};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MealsCategoryResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'filter.php',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = MealsCategoryResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MealsResponse> getMealsByName(String name) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r's': name};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<MealsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'search.php',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = MealsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MealsResponse> getMealsById(String id) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'i': id};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<MealsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'lookup.php',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = MealsResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
