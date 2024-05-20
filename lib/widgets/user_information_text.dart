import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes_app/core/di/injection.dart';
import 'package:recipes_app/user/blocs/user_cubit.dart';
import 'package:recipes_app/user/blocs/user_state.dart';
import 'package:gotrue/src/types/user.dart' as User;

class UserInformationText extends StatelessWidget {
  const UserInformationText({
    super.key,
    required this.userId,
  });
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: BlocProvider(
        create: (context) => getIt<UserCubit>()..getUserInformation(),
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            return state.when(
              initial: () => Center(child: Text('Loading user information...')),
              loading: () => Center(child: CircularProgressIndicator()),
              authenticated: (user) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Welcome, ${user.email}!'),
                    // Display more user information here if needed
                  ],
                ),
              ),
              error: (message) => Center(child: Text('Error: $message')),
              unauthenticated: () {
                throw ('unauthenticated');
              },
            );
          },
        ),
      ),
    );
  }
}
