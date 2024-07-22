import 'package:intl/intl.dart';

String formatTanggal(String tanggalAwal) {
  // Parse string ke DateTime
  DateTime dateTime = DateTime.parse(tanggalAwal);

  // Buat formatter dengan locale Indonesia
  DateFormat formatter = DateFormat('dd MMMM yyyy', 'id_ID');

  // Format tanggal
  String tanggalFormatted = formatter.format(dateTime);

  return tanggalFormatted;
}
