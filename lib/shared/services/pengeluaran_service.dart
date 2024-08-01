import 'package:fspmi/models/pengeluaran.dart';
import 'package:fspmi/shared/utils/dio.dart';

class PengeluaranService {
  Future<List<Pengeluaran>> getPengeluaran(String token) async {
    final response = await Request.get("/pengeluaran", headers: {
      'Authorization': 'Bearer $token',
    });

    List<Pengeluaran> listPengeluaran = [];

    for (var item in response['daftarPengeluaran']) {
      listPengeluaran.add(Pengeluaran.fromJson(item));
    }

    return listPengeluaran;
  }
}
