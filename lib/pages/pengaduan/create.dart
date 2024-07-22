import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fspmi/cubit/pengaduan_cubit.dart';
import 'package:fspmi/cubit/pengaduan_state.dart';
import 'package:fspmi/models/data_pengaduan.dart';
import 'package:fspmi/shared/widgets/dialog/loading.dart';
import 'package:fspmi/shared/widgets/dialog/message.dart';
import 'package:fspmi/shared/widgets/form/input_img.dart';
import 'package:fspmi/shared/widgets/form/input_outline.dart';
import 'package:image_picker/image_picker.dart';

class PengaduanCreate extends StatefulWidget {
  const PengaduanCreate({super.key});

  @override
  State<PengaduanCreate> createState() => _PengaduanCreateState();
}

class _PengaduanCreateState extends State<PengaduanCreate> {
  final _formKey = GlobalKey<FormState>();

  final judul = TextEditingController();
  final detail = TextEditingController();

  File? lampiran;

  Future<File?> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    try {
      final image = await picker.pickImage(source: source);
      if (image == null) return null;

      return File(image.path);
    } on PlatformException catch (e) {
      debugPrint("Failed to pick image: $e");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 72, horizontal: 22),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Form Pengaduan",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 32),
              InputOutline(
                controller: judul,
                label: "Judul",
                hint: "Judul Pengaduan",
                prefixIcon: const Icon(Icons.title_rounded),
              ),
              InputOutline(
                controller: detail,
                label: "Detail",
                hint: "Detail Pengaduan",
                maxLines: 5,
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    widthFactor: 1,
                    heightFactor: 5,
                    child: Icon(Icons.description_rounded),
                  ),
                ),
              ),
              InputImg(
                label: "Upload Lampiran",
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.camera_alt),
                              title: const Text("Camera"),
                              onTap: () async {
                                Navigator.pop(context);
                                final image = await pickImage(ImageSource.camera);
                                setState(() {
                                  if (image != null) {
                                    lampiran = image;
                                  }
                                });
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.image),
                              title: const Text("Gallery"),
                              onTap: () async {
                                Navigator.pop(context);
                                final image = await pickImage(ImageSource.gallery);
                                setState(() {
                                  if (image != null) {
                                    lampiran = image;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: lampiran == null
                    ? const Text(
                        "Pilih Gambar",
                      )
                    : Image.file(
                        lampiran!,
                      ),
              ),
              const SizedBox(height: 32),
              BlocListener<PengaduanCubit, PengaduanState>(
                listener: (context, state) {
                  if (state is PengaduanLoading) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return const LoadingDialog();
                      },
                    );
                  }
                  if (state is PengaduanSuccess) {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return MessageDialog(
                          status: "Berhasil",
                          message: "Pengaduan Berhasil",
                          onOkPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  }
                  if (state is PengaduanFailed) {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return MessageDialog(
                          status: "Gagal",
                          message: state.message,
                          onOkPressed: () {
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  }
                },
                child: FilledButton(
                  onPressed: () {
                    if (lampiran == null) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return MessageDialog(
                            status: "Gagal",
                            message: "Lampiran tidak boleh kosong",
                            onOkPressed: () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
                      return;
                    }

                    if (_formKey.currentState!.validate()) {
                      context.read<PengaduanCubit>().buatPengaduan(
                            DataPengaduan(
                              judul: judul.text,
                              detail: detail.text,
                              lampiran: File(lampiran!.path),
                            ),
                          );
                    }
                  },
                  child: const Text("Kirim"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
