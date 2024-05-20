import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes_app/auth/blocs/auth_cubit.dart'; // Import your AuthCubit class
import 'package:recipes_app/auth/blocs/auth_state.dart'
    as AuthState; // Import your AuthState class
import 'package:recipes_app/core/di/injection.dart';
import 'package:recipes_app/home/views/home_page.dart';
import 'package:recipes_app/router/app_router.dart';
import 'package:gotrue/src/types/user.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocProvider(
        create: (context) => getIt<AuthCubit>(),
        child: BlocConsumer<AuthCubit, AuthState.AuthState>(
          listener: (context, state) {
            state.when(
              authenticated: (currentUser) {
                // Navigate to the home page or authenticated area
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (_) => HomePage(
                            user: currentUser as User,
                          )),
                );
              },
              unauthenticated: () {
                // Do something when user is not authenticated
              },
              loading: () {
                // Do something when loading
                Center(child: CircularProgressIndicator());
              },
              error: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message)),
                );
              },
              initial: () {
                // Do something for initial state
              },
            );
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthCubit>().signIn(
                            emailController.text,
                            passwordController.text,
                          );
                    },
                    child: const Text('Login'),
                  ),
                  TextButton(
                    onPressed: () {
                      context.router.push(RegisterRoute());
                    },
                    child: const Text('Register'),
                  ),
                  TextButton(
                    onPressed: () {
                      context.router.push(ResetPasswordRoute());
                    },
                    child: const Text('Forgot Password?'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
