import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fspmi/cubit/pengaduan_cubit.dart';
import 'package:fspmi/cubit/pengaduan_state.dart';
import 'package:fspmi/pages/pengaduan/create.dart';
import 'package:fspmi/pages/pengaduan/detail.dart';
import 'package:fspmi/shared/utils/helpers.dart';

class PengaduanScreen extends StatefulWidget {
  const PengaduanScreen({super.key});

  @override
  State<PengaduanScreen> createState() => _PengaduanScreenState();
}

class _PengaduanScreenState extends State<PengaduanScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PengaduanCubit>().getPengaduan();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "selesai":
        return Colors.green;
      case "diproses":
        return Colors.yellow.shade800;
      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<PengaduanCubit>().getPengaduan();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 72),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Pengaduan",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  FilledButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PengaduanCreate(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Buat"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            BlocBuilder<PengaduanCubit, PengaduanState>(
              builder: (context, state) {
                if (state is PengaduanLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is PengaduanSuccess) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (var item in state.pengaduan)
                        ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PengaduanDetail(id: item.id),
                              ),
                            );
                          },
                          leading: const Icon(Icons.description_rounded),
                          title: Text(item.judul, maxLines: 1, overflow: TextOverflow.ellipsis),
                          subtitle: Text(formatTanggal(item.tanggalPengaduan.toString())),
                          trailing: Wrap(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: _getStatusColor(item.status),
                                ),
                                child: Text(
                                  item.status.toUpperCase(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.chevron_right),
                            ],
                          ),
                        ),
                    ],
                  );
                }

                if (state is PengaduanFailed) {
                  return Center(
                    child: Text(state.message),
                  );
                }

                return const SizedBox();
              },
            ),
            const SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}
