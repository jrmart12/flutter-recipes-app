// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecipeDtoImpl _$$RecipeDtoImplFromJson(Map<String, dynamic> json) =>
    _$RecipeDtoImpl(
      recipeId: json['recipeId'] as String?,
      name: json['name'] as String,
      category: json['category'] as String,
      imageUrl: json['imageUrl'] as String,
      instructions: json['instructions'] as String,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      measurements: (json['measurements'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$$RecipeDtoImplToJson(_$RecipeDtoImpl instance) =>
    <String, dynamic>{
      'recipeId': instance.recipeId,
      'name': instance.name,
      'category': instance.category,
      'imageUrl': instance.imageUrl,
      'instructions': instance.instructions,
      'ingredients': instance.ingredients,
      'measurements': instance.measurements,
      'userId': instance.userId,
    };
