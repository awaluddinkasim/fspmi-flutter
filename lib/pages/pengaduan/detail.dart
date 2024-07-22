import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fspmi/models/data_pengaduan_balasan.dart';
import 'package:fspmi/models/pengaduan.dart';
import 'package:fspmi/shared/constants.dart';
import 'package:fspmi/shared/services/pengaduan_service.dart';
import 'package:fspmi/shared/utils/helpers.dart';
import 'package:fspmi/shared/widgets/dialog/loading.dart';
import 'package:fspmi/shared/widgets/form/input_outline.dart';

FlutterSecureStorage storage = const FlutterSecureStorage();

class PengaduanDetail extends StatefulWidget {
  const PengaduanDetail({super.key, required this.id});

  final int id;

  @override
  State<PengaduanDetail> createState() => _PengaduanDetailState();
}

class _PengaduanDetailState extends State<PengaduanDetail> {
  final _pengaduanService = PengaduanService();

  bool _isLoading = true;

  final balasan = TextEditingController();

  Pengaduan? pengaduan;

  @override
  void initState() {
    super.initState();
    _fetchPengaduan();
  }

  Future<void> _fetchPengaduan() async {
    final token = await storage.read(key: 'token');
    final result = await _pengaduanService.getDetail(token!, widget.id);

    setState(() {
      pengaduan = result;
      _isLoading = false;
    });
  }

  Future<void> balasPengaduan() async {
    final messanger = ScaffoldMessenger.of(context);

    final token = await storage.read(key: 'token');

    try {
      await _pengaduanService.balasPengaduan(
        token!,
        DataPengaduanBalasan(idPengaduan: widget.id, balasan: balasan.text),
      );

      balasan.text = '';
    } catch (e) {
      messanger.showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: RefreshIndicator(
        onRefresh: _fetchPengaduan,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 48),
                    const Text(
                      "Detail Pengaduan",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (_isLoading)
                      const Loading()
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            pengaduan!.judul,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(pengaduan!.detail),
                              ),
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 80,
                                child: Image.network(
                                  "${Constants.baseUrl}/f/foto-lampiran/${pengaduan!.lampiran}",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    const SizedBox(height: 22),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Balasan",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FilledButton.icon(
                          onPressed: pengaduan!.status == 'selesai'
                              ? null
                              : () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context).viewInsets.bottom,
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(18.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              const SizedBox(height: 16),
                                              const Text(
                                                "Balas Pengaduan",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 16),
                                              InputOutline(
                                                controller: balasan,
                                                label: "Balasan",
                                                hint: "Balas pengaduan ini",
                                                maxLines: 4,
                                                prefixIcon: const Padding(
                                                  padding: EdgeInsets.only(left: 12),
                                                  child: Align(
                                                    alignment: Alignment.topLeft,
                                                    widthFactor: 1,
                                                    heightFactor: 4,
                                                    child: Icon(Icons.description_rounded),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 16),
                                              FilledButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) => const LoadingDialog(),
                                                  );
                                                  balasPengaduan().then((_) {
                                                    _fetchPengaduan();
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Kirim"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                          icon: const Icon(Icons.reply),
                          label: const Text("Balas"),
                        ),
                      ],
                    ),
                    if (!_isLoading)
                      if (pengaduan!.balasan.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 32),
                          child: Text(
                            "Belum ada balasan",
                            textAlign: TextAlign.center,
                          ),
                        )
                      else
                        for (var item in pengaduan!.balasan)
                          ListTile(
                            title: Text(item.pengirim == 'admin' ? 'Admin' : 'Anda'),
                            subtitle: Text(item.balasan),
                            trailing: SizedBox(
                              width: 40,
                              child: Text(
                                formatTanggal(item.tanggal.toString()),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                    else
                      const Loading(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 32),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
