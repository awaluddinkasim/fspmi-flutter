import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fspmi/cubit/auth_cubit.dart';
import 'package:fspmi/cubit/iuran_cubit.dart';
import 'package:fspmi/cubit/iuran_state.dart';
import 'package:fspmi/pages/iuran.dart';
import 'package:fspmi/pages/user.dart';
import 'package:fspmi/shared/constants.dart';
import 'package:fspmi/shared/widgets/iuran_detail.dart';
import 'package:intl/intl.dart';

FlutterSecureStorage storage = const FlutterSecureStorage();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<IuranCubit>().getIuran();
  }

  @override
  Widget build(BuildContext context) {
    final number = NumberFormat('#,###');
    final user = context.read<AuthCubit>().currentUser;

    return RefreshIndicator(
      onRefresh: () async {
        context.read<IuranCubit>().getIuran();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Stack(
          children: [
            ClipPath(
              clipper: Clipper(),
              child: Container(
                height: 360,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.7),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Selamat Datang",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const UserScreen(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                SizedBox(
                                  height: 18,
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundImage: NetworkImage(
                                      "${Constants.baseUrl}/f/foto-profile/${user!.fotoProfile}",
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  user.nama,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 48,
                      horizontal: 22,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          "Total Iuran Anda",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        BlocBuilder<IuranCubit, IuranState>(
                          builder: (context, state) {
                            if (state is IuranLoading) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              );
                            } else if (state is IuranSuccess) {
                              return Text(
                                "Rp. ${number.format(state.iuran.totalIuran)}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              );
                            }

                            return const Text(
                              "Rp. 0",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 18),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Pembayaran Bulan ini",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              BlocBuilder<IuranCubit, IuranState>(
                                builder: (context, state) {
                                  if (state is IuranLoading) {
                                    return const SizedBox(
                                      height: 12,
                                      width: 12,
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state is IuranSuccess) {
                                    return Text(
                                      state.iuran.status,
                                    );
                                  }

                                  return const Text("Error");
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "List Iuran Terbaru",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<IuranCubit>().getIuran();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const IuranScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Lihat semua",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  BlocBuilder<IuranCubit, IuranState>(
                    builder: (context, state) {
                      if (state is IuranLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is IuranSuccess) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (state.iuran.items.isNotEmpty)
                              for (var item in state.iuran.items.reversed.take(5))
                                IuranDetail(item: item)
                            else
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(18.0),
                                  child: Text("Belum ada iuran"),
                                ),
                              ),
                          ],
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 55);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 55);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
