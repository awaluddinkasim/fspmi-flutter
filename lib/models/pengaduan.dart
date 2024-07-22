import 'package:fspmi/models/pengaduan_balasan.dart';

class Pengaduan {
  int id;
  String judul;
  String detail;
  String lampiran;
  DateTime tanggalPengaduan;
  String status;
  List<PengaduanBalasan> balasan;

  Pengaduan({
    required this.id,
    required this.judul,
    required this.detail,
    required this.lampiran,
    required this.tanggalPengaduan,
    required this.status,
    required this.balasan,
  });

  factory Pengaduan.fromJson(Map<String, dynamic> json) {
    return Pengaduan(
      id: json['id'],
      judul: json['judul'],
      detail: json['detail'],
      lampiran: json['lampiran'],
      tanggalPengaduan: DateTime.parse(json['tgl_pengaduan']),
      status: json['status'],
      balasan: json['balasan']
          .map<PengaduanBalasan>(
            (json) => PengaduanBalasan.fromJson(json),
          )
          .toList(),
    );
  }
}
