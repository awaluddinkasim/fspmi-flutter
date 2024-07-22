import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fspmi/cubit/register_state.dart';
import 'package:fspmi/models/data_register.dart';
import 'package:fspmi/shared/services/auth_service.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final _authService = AuthService();

  RegisterCubit() : super(RegisterInitial());

  Future<void> register(DataRegister data) async {
    emit(RegisterLoading());

    try {
      final result = await _authService.register(data);

      emit(RegisterSuccess(result));
    } catch (e) {
      emit(RegisterFailed(e.toString()));
    }
  }
}
