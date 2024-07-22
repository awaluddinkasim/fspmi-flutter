import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fspmi/cubit/iuran_state.dart';
import 'package:fspmi/shared/services/iuran_service.dart';

FlutterSecureStorage storage = const FlutterSecureStorage();

class IuranCubit extends Cubit<IuranState> {
  final _iuranService = IuranService();

  IuranCubit() : super(IuranInitial());

  Future<void> getIuran() async {
    emit(IuranLoading());
    try {
      final token = await storage.read(key: 'token');

      final iuran = await _iuranService.getIuran(token!);

      emit(IuranSuccess(iuran));
    } catch (e) {
      emit(IuranFailed(e.toString()));
    }
  }
}
