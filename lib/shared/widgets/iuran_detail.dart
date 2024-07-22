import 'package:flutter/material.dart';
import 'package:fspmi/models/iuran_item.dart';
import 'package:fspmi/shared/utils/helpers.dart';
import 'package:intl/intl.dart';

class IuranDetail extends StatelessWidget {
  const IuranDetail({
    super.key,
    required this.item,
  });

  final IuranItem item;

  @override
  Widget build(BuildContext context) {
    final number = NumberFormat('#,###');

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 22,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Rp. ${number.format(item.nominal)}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(formatTanggal("${item.tanggalBayar}")),
        ],
      ),
    );
  }
}
