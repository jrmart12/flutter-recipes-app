import 'package:flutter/material.dart';
import 'package:recipes_app/auth/services/auth_service.dart';
import 'package:recipes_app/core/di/injection.dart';
import 'package:recipes_app/router/app_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:gotrue/src/types/user.dart' as User;
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://hhvtctrftheorcvdwgbo.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhodnRjdHJmdGhlb3JjdmR3Z2JvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTYxMzI5NjQsImV4cCI6MjAzMTcwODk2NH0.VueYX7QRMX4R2pE2cxSHDYc-tYJhiLVKj4tQxnhBIDQ',
  );
  configureDependencies();
  runApp(App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _appRouter = AppRouter();

  @override
  void initState() {
    super.initState();

    /// Listen for authentication events and redirect to
    /// correct page when key events are detected.
    Supabase.instance.client.auth.onAuthStateChange.listen((authState) {
      final event = authState.event;
      final session = authState.session;
      print('session::::: $session');
      print('event::::::: $event');
      if (event == AuthChangeEvent.signedIn) {
        if (session != null) {
          _appRouter
            ..popUntilRoot()
            ..replace(HomeRoute(user: session.user as User.User));
        } else {
          getIt<AuthService>().signOut();
        }
      } else if (event == AuthChangeEvent.signedOut) {
        _appRouter
          ..popUntilRoot()
          ..replace(LoginRoute());
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Recipes Auth App',
      routerConfig: _appRouter.config(),
    );
  }
}