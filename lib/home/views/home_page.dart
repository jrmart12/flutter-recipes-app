import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes_app/auth/blocs/auth_cubit.dart';
import 'package:recipes_app/auth/blocs/auth_state.dart';
import 'package:recipes_app/user/blocs/user_cubit.dart';
import 'package:recipes_app/user/blocs/user_state.dart';
import 'package:gotrue/src/types/user.dart';
import 'package:recipes_app/widgets/user_information_text.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: context.read<AuthCubit>(),
          ),
          BlocProvider.value(
            value: context.read<UserCubit>()..getUserInformation(),
          ),
        ],
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            return state.maybeWhen(
              authenticated: (user) {
                return SafeArea(
                  top: true,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(height: 16),
                        
                        UserInformationText(userId: user.userId),
                      ],
                    ),
                  ),
                );
              },
              orElse: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
