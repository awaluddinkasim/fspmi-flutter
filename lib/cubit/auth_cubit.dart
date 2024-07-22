import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fspmi/cubit/auth_state.dart';
import 'package:fspmi/models/data_login.dart';
import 'package:fspmi/models/user.dart';
import 'package:fspmi/shared/services/auth_service.dart';

FlutterSecureStorage storage = const FlutterSecureStorage();

class AuthCubit extends Cubit<AuthState> {
  final _authService = AuthService();
  User? get currentUser => state is AuthSuccess ? (state as AuthSuccess).auth.user : null;

  AuthCubit() : super(AuthInitial()) {
    checkAuth();
  }

  Future<void> checkAuth() async {
    emit(AuthLoading());

    try {
      final token = await storage.read(key: 'token');

      if (token != null) {
        final result = await _authService.getUser(token: token);

        emit(AuthSuccess(result));
      } else {
        emit(AuthInitial());
        await storage.delete(key: 'token');
      }
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  Future<void> login(DataLogin data) async {
    emit(AuthLoading());

    try {
      final result = await _authService.login(data);

      await storage.write(key: 'token', value: result.token);

      emit(AuthSuccess(result));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  Future<void> logout() async {
    if (state is AuthSuccess) {
      final currentState = state as AuthSuccess;

      emit(AuthLoading());

      try {
        await _authService.logout(token: currentState.auth.token);
        await storage.delete(key: 'token');

        emit(AuthInitial());
      } catch (e) {
        emit(AuthFailed(e.toString()));
      }
    }
  }
}
