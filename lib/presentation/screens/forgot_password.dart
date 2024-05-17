
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes_app/auth/blocs/auth_bloc.dart';
import 'package:recipes_app/auth/blocs/auth_state.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forgot Password')),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthState && state is AuthStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is AuthForgotPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Password reset email sent')),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Dispatch forgot password event
                    BlocProvider.of<AuthBloc>(context).forgotPassword(email);
                  },
                  child: Text('Reset Password'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}