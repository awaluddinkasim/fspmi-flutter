class DataPengaduanBalasan {
  int idPengaduan;
  String balasan;

  DataPengaduanBalasan({
    required this.idPengaduan,
    required this.balasan,
  });

  Map<String, dynamic> toJson() => {
        'id_pengaduan': idPengaduan,
        'balasan': balasan,
      };
}
