import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes_app/auth/blocs/auth_cubit.dart';
import 'package:recipes_app/auth/services/auth_service.dart';
import 'package:recipes_app/core/di/injection.dart';
import 'package:recipes_app/router/app_router.dart';
import 'package:recipes_app/user/blocs/user_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:gotrue/src/types/user.dart' as User;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://hhvtctrftheorcvdwgbo.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhodnRjdHJmdGhlb3JjdmR3Z2JvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTYxMzI5NjQsImV4cCI6MjAzMTcwODk2NH0.VueYX7QRMX4R2pE2cxSHDYc-tYJhiLVKj4tQxnhBIDQ',
  );
  configureDependencies();
  runApp(MyApp(
    authCubit: getIt<AuthCubit>(),
    userCubit: getIt<UserCubit>(),
  ));
}

class MyApp extends StatefulWidget {
  final AuthCubit authCubit;
  final UserCubit userCubit;

  const MyApp({Key? key, required this.authCubit, required this.userCubit})
      : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
      try {
        if (event == AuthChangeEvent.signedIn) {
          if (session != null) {
            _appRouter
              ..popUntilRoot()
              ..replace(HomeRoute());
          } else {
            getIt<AuthService>().signOut();
          }
        } else if (event == AuthChangeEvent.signedOut) {
          _appRouter
            ..popUntilRoot()
            ..replace(LoginRoute());
        }
      } catch (error) {
        print('Error occurred in onAuthStateChange: $error');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: widget.authCubit),
        BlocProvider.value(value: widget.userCubit),
      ],
      child: MaterialApp.router(
        title: 'Recipes Auth App',
        routerConfig: _appRouter.config(),
      ),
    );
  }
}
