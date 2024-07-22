import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fspmi/cubit/pengaduan_state.dart';
import 'package:fspmi/models/data_pengaduan.dart';
import 'package:fspmi/shared/services/pengaduan_service.dart';

FlutterSecureStorage storage = const FlutterSecureStorage();

class PengaduanCubit extends Cubit<PengaduanState> {
  final _pengaduanService = PengaduanService();

  PengaduanCubit() : super(PengaduanInitial());

  Future<void> getPengaduan() async {
    emit(PengaduanLoading());

    try {
      final token = await storage.read(key: 'token');

      final daftarPengaduan = await _pengaduanService.getPengaduan(token!);

      emit(PengaduanSuccess(daftarPengaduan));
    } catch (e) {
      emit(PengaduanFailed(e.toString()));
    }
  }

  Future<void> buatPengaduan(DataPengaduan data) async {
    emit(PengaduanLoading());

    try {
      final token = await storage.read(key: 'token');

      final daftarPengaduan = await _pengaduanService.postPengaduan(token!, data);

      emit(PengaduanSuccess(daftarPengaduan));
    } catch (e) {
      emit(PengaduanFailed(e.toString()));
    }
  }
}
