class IuranItem {
  int nominal;
  DateTime tanggalBayar;

  IuranItem({
    required this.nominal,
    required this.tanggalBayar,
  });

  factory IuranItem.fromJson(Map<String, dynamic> json) {
    return IuranItem(
      nominal: json['nominal'],
      tanggalBayar: DateTime.parse(json['tgl_bayar']),
    );
  }
}
