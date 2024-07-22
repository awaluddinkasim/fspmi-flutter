import 'package:dio/dio.dart';
import 'package:fspmi/models/data_pengaduan.dart';
import 'package:fspmi/models/data_pengaduan_balasan.dart';
import 'package:fspmi/models/pengaduan.dart';
import 'package:fspmi/shared/utils/dio.dart';

class PengaduanService {
  Future<List<Pengaduan>> getPengaduan(String token) async {
    final response = await Request.get("/pengaduan", headers: {
      'Authorization': 'Bearer $token',
    });

    List<Pengaduan> listPengaduan = [];

    for (var item in response['daftarPengaduan']) {
      listPengaduan.add(Pengaduan.fromJson(item));
    }

    return listPengaduan;
  }

  Future<List<Pengaduan>> postPengaduan(String token, DataPengaduan data) async {
    final formData = FormData.fromMap({
      'judul': data.judul,
      'detail': data.detail,
      'lampiran': await MultipartFile.fromFile(data.lampiran!.path),
    });

    final response = await Request.post(
      "/pengaduan",
      data: formData,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    List<Pengaduan> listPengaduan = [];

    for (var item in response['daftarPengaduan']) {
      listPengaduan.add(Pengaduan.fromJson(item));
    }

    return listPengaduan;
  }

  Future<Pengaduan> getDetail(String token, int id) async {
    final response = await Request.get("/pengaduan/$id", headers: {
      'Authorization': 'Bearer $token',
    });

    return Pengaduan.fromJson(response['pengaduan']);
  }

  Future<String> balasPengaduan(String token, DataPengaduanBalasan data) async {
    final response = await Request.post(
      "/pengaduan/balas",
      data: data.toJson(),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    return response['message'];
  }
}
