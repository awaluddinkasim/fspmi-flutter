import 'dart:io';

class DataPengaduan {
  String judul;
  String detail;
  File? lampiran;

  DataPengaduan({
    required this.judul,
    required this.detail,
    this.lampiran,
  });
}
