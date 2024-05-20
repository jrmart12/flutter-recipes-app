import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:recipes_app/router/app_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    redirectToRoute();
  }

  Future<void> redirectToRoute() async {
    // Add a delay to simulate loading
    await Future.delayed(const Duration(seconds: 2));

    // Check if user is authenticated
    final session = await Supabase.instance.client.auth.currentSession;
    final isAuthenticated = session?.accessToken != null;
    final user = await Supabase.instance.client.auth.currentUser;
    // Redirect to appropriate route based on authentication status
    if (isAuthenticated && user != null) {
      context.router.replace(HomeRoute(user: user));
    } else {
      context.router.replace(LoginRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }
}
