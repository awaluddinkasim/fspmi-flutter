import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fspmi/cubit/register_cubit.dart';
import 'package:fspmi/cubit/register_state.dart';
import 'package:fspmi/models/data_register.dart';
import 'package:fspmi/shared/widgets/dialog/loading.dart';
import 'package:fspmi/shared/widgets/dialog/message.dart';
import 'package:fspmi/shared/widgets/form/dropdown_outline.dart';
import 'package:fspmi/shared/widgets/form/input_img.dart';
import 'package:fspmi/shared/widgets/form/input_outline.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final nama = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final noHp = TextEditingController();

  String? jk;

  File? fotoProfile;
  File? fotoKtp;

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
        padding: const EdgeInsets.symmetric(vertical: 96, horizontal: 22),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InputOutline(
                controller: nama,
                prefixIcon: const Icon(Icons.badge),
                keyboardType: TextInputType.name,
                label: "Nama",
                hint: "Masukkan Nama",
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lengkapi data ini";
                  }
                  return null;
                },
              ),
              InputOutline(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.mail),
                label: "Email",
                hint: "Masukkan Email",
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lengkapi data ini";
                  }
                  return null;
                },
              ),
              InputOutline(
                controller: password,
                prefixIcon: const Icon(Icons.lock),
                obscureText: true,
                label: "Password",
                hint: "Masukkan Password",
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lengkapi data ini";
                  }
                  if (value.length < 8) {
                    return "Password harus lebih dari 8 karakter";
                  }
                  return null;
                },
              ),
              DropdownOutline(
                value: jk,
                label: "Jenis Kelamin",
                hint: "Pilih Jenis Kelamin",
                items: const [
                  DropdownMenuItem(
                    value: "L",
                    child: Text("Laki-laki"),
                  ),
                  DropdownMenuItem(
                    value: "P",
                    child: Text("Perempuan"),
                  ),
                ],
                onChanged: (value) {
                  jk = value;
                },
                prefixIcon: const Icon(Icons.person),
                validator: (value) {
                  if (value == null) {
                    return "Lengkapi data ini";
                  }
                  return null;
                },
              ),
              InputImg(
                label: "Upload Foto Diri (Max. 2 MB)",
                child: fotoProfile == null
                    ? const Text(
                        "Pilih Gambar",
                      )
                    : Image.file(
                        fotoProfile!,
                      ),
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
                                    fotoProfile = image;
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
                                    fotoProfile = image;
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
              ),
              InputImg(
                label: "Upload Foto KTP (Max. 2 MB)",
                child: fotoKtp == null
                    ? const Text(
                        "Pilih Gambar",
                      )
                    : Image.file(
                        fotoKtp!,
                      ),
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
                                    fotoKtp = image;
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
                                    fotoKtp = image;
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
              ),
              InputOutline(
                controller: noHp,
                prefixIcon: const Icon(Icons.phone),
                keyboardType: TextInputType.number,
                label: "No. HP",
                hint: "Masukkan No. HP",
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lengkapi data ini";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              BlocListener<RegisterCubit, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterLoading) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return const LoadingDialog();
                      },
                    );
                  }
                  if (state is RegisterSuccess) {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return MessageDialog(
                          status: "Berhasil",
                          message: state.message,
                          onOkPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  }
                  if (state is RegisterFailed) {
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
                    if (fotoKtp == null || fotoProfile == null) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return MessageDialog(
                            status: "Gagal",
                            message: "Foto tidak boleh kosong",
                            onOkPressed: () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
                      return;
                    }

                    if (_formKey.currentState!.validate()) {
                      context.read<RegisterCubit>().register(
                            DataRegister(
                              nama: nama.text,
                              email: email.text,
                              password: password.text,
                              jk: jk!,
                              noHp: noHp.text,
                              foto: File(fotoProfile!.path),
                              ktp: File(fotoKtp!.path),
                            ),
                          );
                    }
                  },
                  child: const Text("Daftar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
