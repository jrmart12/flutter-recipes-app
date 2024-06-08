import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes_app/auth/blocs/auth_cubit.dart';
import 'package:recipes_app/recipes/blocs/recipe_cubit.dart';
import 'package:recipes_app/recipes/dtos/recipe_dto.dart';

@RoutePage()
class RecipeFormPage extends StatefulWidget {
  final RecipeDto? recipe;

  const RecipeFormPage({Key? key, this.recipe}) : super(key: key);

  @override
  _RecipeFormPageState createState() => _RecipeFormPageState();
}

class _RecipeFormPageState extends State<RecipeFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _categoryController;
  late TextEditingController _imageUrlController;
  late TextEditingController _instructionsController;
  final List<TextEditingController> _ingredientsControllers = [];
  final List<TextEditingController> _measurementsControllers = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.recipe?.name);
    _categoryController = TextEditingController(text: widget.recipe?.category);
    _imageUrlController = TextEditingController(text: widget.recipe?.imageUrl);
    _instructionsController =
        TextEditingController(text: widget.recipe?.instructions);
    if (widget.recipe != null) {
      _ingredientsControllers.addAll(
        widget.recipe!.ingredients
            .map((ingredient) => TextEditingController(text: ingredient))
            .toList(),
      );
      _measurementsControllers.addAll(
        widget.recipe!.measurements
            .map((measurement) => TextEditingController(text: measurement))
            .toList(),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _imageUrlController.dispose();
    _instructionsController.dispose();
    _ingredientsControllers.forEach((controller) => controller.dispose());
    _measurementsControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _addIngredient() {
    setState(() {
      _ingredientsControllers.add(TextEditingController());
      _measurementsControllers.add(TextEditingController());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe == null ? 'Create Recipe' : 'Edit Recipe'),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: context.read<AuthCubit>(),
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _categoryController,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a category';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _imageUrlController,
                    decoration: const InputDecoration(
                      labelText: 'Image URL',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an image URL';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _instructionsController,
                    decoration: const InputDecoration(
                      labelText: 'Instructions',
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter instructions';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Ingredients',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  ...List.generate(
                    _ingredientsControllers.length,
                    (index) => TextFormField(
                      controller: _ingredientsControllers[index],
                      decoration: InputDecoration(
                        labelText: 'Ingredient ${index + 1}',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an ingredient';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Measurements',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  ...List.generate(
                    _measurementsControllers.length,
                    (index) => TextFormField(
                      controller: _measurementsControllers[index],
                      decoration: InputDecoration(
                        labelText: 'Measurement ${index + 1}',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a measurement';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (widget.recipe == null) {
                          final userRecipe = RecipeDto(
                            name: _nameController.text,
                            category: _categoryController.text,
                            imageUrl: _imageUrlController.text,
                            instructions: _instructionsController.text,
                            ingredients: _ingredientsControllers
                                .map((controller) => controller.text)
                                .toList(),
                            measurements: _measurementsControllers
                                .map((controller) => controller.text)
                                .toList(),
                          );
                          context.read<RecipeCubit>().createRecipe(userRecipe);
                        } else {
                          final userRecipe = RecipeDto(
                            recipeId: widget.recipe!.recipeId,
                            name: _nameController.text,
                            category: _categoryController.text,
                            imageUrl: _imageUrlController.text,
                            instructions: _instructionsController.text,
                            ingredients: _ingredientsControllers
                                .map((controller) => controller.text)
                                .toList(),
                            measurements: _measurementsControllers
                                .map((controller) => controller.text)
                                .toList(),
                          );
                          print(userRecipe);
                          print(widget.recipe?.recipeId);
                          context.read<RecipeCubit>().updateRecipe(
                              userRecipe, widget.recipe!.recipeId);
                        }
                        Navigator.pop(context);
                      }
                    },
                    child: Text(widget.recipe == null ? 'Create' : 'Update'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addIngredient,
        child: const Icon(Icons.add),
      ),
    );
  }
}
