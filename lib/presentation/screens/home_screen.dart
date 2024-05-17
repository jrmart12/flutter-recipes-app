import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:recipes_app/presentation/routes/app_router.gr.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: (){
            AutoRouter.of(context).push(const RecipeRoute());
          }, child: const Text('GO to recipes screen'))
        ],
      ),
    );
  }
}