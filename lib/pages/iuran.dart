import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fspmi/cubit/iuran_cubit.dart';
import 'package:fspmi/cubit/iuran_state.dart';
import 'package:fspmi/shared/widgets/iuran_detail.dart';

class IuranScreen extends StatelessWidget {
  const IuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Iuran"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
        child: BlocBuilder<IuranCubit, IuranState>(builder: (context, state) {
          if (state is IuranLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is IuranSuccess) {
            return Column(
              children: [
                for (var item in state.iuran.items) IuranDetail(item: item),
              ],
            );
          }

          return const SizedBox();
        }),
      ),
    );
  }
}
