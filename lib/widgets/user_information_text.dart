import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes_app/user/blocs/user_cubit.dart';
import 'package:recipes_app/user/blocs/user_state.dart';

class UserInformationText extends StatelessWidget {
  const UserInformationText({
    super.key,
    required this.userId,
  });
  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return state.when(
          initial: () => Center(child: Text('Loading user information...')),
          loading: () => Center(child: CircularProgressIndicator()),
          authenticated: (user) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome, ${user.fullName}'),
              // Display more user information here if needed
            ],
          ),
          error: (message) => Center(child: Text('Error: $message')),
          unauthenticated: () {
            throw ('unauthenticated');
          },
        );
      },
    );
  }
}
