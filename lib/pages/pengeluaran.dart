import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fspmi/models/pengeluaran.dart';
import 'package:fspmi/shared/services/pengeluaran_service.dart';
import 'package:fspmi/shared/utils/helpers.dart';

FlutterSecureStorage storage = const FlutterSecureStorage();

class PengeluaranScreen extends StatefulWidget {
  const PengeluaranScreen({super.key});

  @override
  State<PengeluaranScreen> createState() => _PengeluaranScreenState();
}

class _PengeluaranScreenState extends State<PengeluaranScreen> {
  final _pengeluaranService = PengeluaranService();

  bool _isLoading = true;
  List<Pengeluaran> _pengeluaran = [];

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  Future<void> _fetch() async {
    final token = await storage.read(key: 'token');

    final result = await _pengeluaranService.getPengeluaran(token!);

    setState(() {
      _pengeluaran = result;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _fetch,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 82, horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Pengeluaran",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 32),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
            else
              for (var item in _pengeluaran)
                Container(
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
                      Text(item.keperluan, style: const TextStyle(fontSize: 16)),
                      Text(
                        "Rp. ${item.nominal}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(formatTanggal("${item.tglPengeluaran}")),
                    ],
                  ),
                ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
