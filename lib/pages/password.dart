import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fspmi/shared/utils/dio.dart';
import 'package:fspmi/shared/widgets/dialog/loading.dart';
import 'package:fspmi/shared/widgets/form/input_outline.dart';

FlutterSecureStorage storage = const FlutterSecureStorage();

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  Future<void> _updatePassword() async {
    if (_formKey.currentState!.validate()) {
      final scaffold = ScaffoldMessenger.of(context);

      try {
        final navigator = Navigator.of(context);
        final token = await storage.read(key: 'token');

        await Request.patch('/password', data: {
          'password': _password.text,
        }, headers: {
          'Authorization': 'Bearer $token',
        });

        navigator.pop();
        navigator.pop();
      } catch (e) {
        scaffold.showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    }
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
                controller: _password,
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
              InputOutline(
                controller: _confirmPassword,
                prefixIcon: const Icon(Icons.lock),
                obscureText: true,
                label: "Konfirmasi Password",
                hint: "Masukkan Ulang Password",
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lengkapi data ini";
                  }

                  if (value != _password.text) {
                    return "Password tidak sama";
                  }

                  if (value.length < 8) {
                    return "Password harus lebih dari 8 karakter";
                  }
                  return null;
                },
              ),
              FilledButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const LoadingDialog(),
                  );
                  _updatePassword();
                },
                child: const Text("Simpan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
