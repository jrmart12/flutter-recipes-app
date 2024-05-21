import 'package:bloc/bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../auth/services/auth_service.dart'; // Import the AuthService if needed
import '../services/user_service.dart';
import 'package:gotrue/src/types/user.dart' as User;
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserService _userService;

  UserCubit(this._userService) : super(UserState.initial());

  Future<void> getUserInformation() async {
    emit(const UserState.loading());
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      emit(const UserState.unauthenticated());
      return;
    }

    try {
      final result = await _userService.getUserInfo(user.id);
      result?.fold(
        (failure) => emit(const UserState.error('Failed to fetch user info')),
        (userDto) => emit(UserState.authenticated(userDto)),
      );
    } on Object catch (error, stackTrace) {
      print('Error occurred while fetching user info: $error\n$stackTrace');
      emit(const UserState.error('An unexpected error occurred'));
    }
  }

  Future<void> setUserInformation(String fullName) async {
    emit(const UserState.loading());
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      emit(const UserState.unauthenticated());
      return;
    }

    try {
      final result = await _userService.setUserInfo(
          user.id, user.email!, fullName, user.createdAt);
      result?.fold(
        (failure) => emit(const UserState.error('Failed to fetch user info')),
        (userDto) => emit(UserState.authenticated(userDto)),
      );
    } on Object catch (error, stackTrace) {
      print('Error occurred while fetching user info: $error\n$stackTrace');
      emit(const UserState.error('An unexpected error occurred'));
    }
  }
}
