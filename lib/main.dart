import 'package:flutter/material.dart';
// import 'package:recipes_app/injection.config.dart';
import 'package:recipes_app/presentation/routes/app_router.dart';

void main() {
  // configureInjection(Environment.prod);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  
  AppRouter appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // hook up router to MaterialApp
      routerConfig: appRouter.config(),
    );
  }
}