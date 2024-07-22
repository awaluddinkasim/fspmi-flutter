class PengaduanBalasan {
  String pengirim;
  String balasan;
  String tanggal;

  PengaduanBalasan({
    required this.pengirim,
    required this.balasan,
    required this.tanggal,
  });

  factory PengaduanBalasan.fromJson(Map<String, dynamic> json) {
    return PengaduanBalasan(
      pengirim: json['pengirim'],
      balasan: json['isi_balasan'],
      tanggal: json['created_at'],
    );
  }
}
