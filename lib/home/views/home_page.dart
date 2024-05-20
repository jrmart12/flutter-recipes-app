import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes_app/auth/blocs/auth_cubit.dart';
import 'package:recipes_app/user/blocs/user_cubit.dart';
import 'package:recipes_app/user/blocs/user_state.dart';
import 'package:gotrue/src/types/user.dart';
import 'package:recipes_app/core/di/injection.dart';
import 'package:recipes_app/widgets/user_information_text.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => getIt<AuthCubit>()),
        BlocProvider<UserCubit>(create: (context) => getIt<UserCubit>()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            // Your listener logic here
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthCubit>().signOut();
                    },
                    child: const Text('Log Out'),
                  ),
                  UserInformationText(userId: user.id),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
