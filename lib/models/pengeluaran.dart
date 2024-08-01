class Pengeluaran {
  String keperluan;
  int nominal;
  DateTime tglPengeluaran;

  Pengeluaran({
    required this.keperluan,
    required this.nominal,
    required this.tglPengeluaran,
  });

  factory Pengeluaran.fromJson(Map<String, dynamic> json) {
    return Pengeluaran(
      keperluan: json['keperluan'],
      nominal: json['jumlah'],
      tglPengeluaran: DateTime.parse(json['tanggal']),
    );
  }
}
