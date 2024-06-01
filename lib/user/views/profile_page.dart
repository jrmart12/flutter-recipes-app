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
class ProfilePage extends StatelessWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'My Recipes'),
              Tab(text: 'Profile'),
            ],
            indicatorColor: const Color.fromRGBO(
                89, 126, 247, 1.000), // Change the indicator color
            labelColor: const Color.fromRGBO(89, 126, 247, 1.000),
          ),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: context.read<AuthCubit>(),
            ),
            BlocProvider.value(
              value: context.read<UserCubit>()..getUserInformation(),
            ),
          ],
          child: TabBarView(
            children: [
              // My Recipes tab content
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'All Recipes',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Navigate to the "New Recipe" view
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 5, // Replace with your actual recipe count
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            print('clcicked');
                            // Navigate to the recipe details view
                          },
                          child: Card(
                            elevation:
                                4, // Adjust the elevation value for the desired shadow
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: ListTile(
                              title: Text('Recipe ${index + 1}'),
                              subtitle: const Text('Recipe description'),
                              trailing: const Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              BlocBuilder<UserCubit, UserState>(
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
                              
                              ElevatedButton(
                                onPressed: () {
                                  context.read<AuthCubit>().signOut();
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromRGBO(
                                        89, 126, 247, 1.000),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 60)),
                                child: const Text('Log Out'),
                              ),
                              const SizedBox(height: 36),
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
            ],
          ),
        ),
      ),
    );
  }
}
