import 'package:fspmi/models/iuran_item.dart';

class Iuran {
  String status;
  int totalIuran;
  List<IuranItem> items;

  Iuran({
    required this.status,
    required this.totalIuran,
    required this.items,
  });

  factory Iuran.fromJson(Map<String, dynamic> json) {
    return Iuran(
      status: json['status'],
      totalIuran: json['total_iuran'],
      items: json['items']
          .map<IuranItem>(
            (json) => IuranItem.fromJson(json),
          )
          .toList(),
    );
  }
}
