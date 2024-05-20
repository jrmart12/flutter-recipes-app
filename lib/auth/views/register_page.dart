import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes_app/home/views/home_page.dart';
import 'package:recipes_app/auth/blocs/auth_cubit.dart'; // Import your AuthCubit class
import 'package:recipes_app/auth/blocs/auth_state.dart'; // Import your AuthState class
import 'package:recipes_app/core/di/injection.dart';
import 'package:gotrue/src/types/user.dart';

@RoutePage()
class RegisterPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => getIt<AuthCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: BlocConsumer<AuthCubit, AuthState>(
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
              initial: () {},
              loading: () {
                Center(child: CircularProgressIndicator());
              },
              unauthenticated: () {},
              error: (String message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message)),
                );
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
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthCubit>().signUp(
                            emailController.text,
                            passwordController.text,
                          );
                    },
                    child: const Text('Register'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Back to Login'),
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

