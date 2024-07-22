import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fspmi/cubit/auth_cubit.dart';
import 'package:fspmi/cubit/auth_state.dart';
import 'package:fspmi/models/data_login.dart';
import 'package:fspmi/pages/app.dart';
import 'package:fspmi/pages/auth/register.dart';
import 'package:fspmi/shared/widgets/dialog/loading.dart';
import 'package:fspmi/shared/widgets/dialog/message.dart';
import 'package:fspmi/shared/widgets/form/input_styled.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();

  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 160, horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Image.asset(
                "assets/logo.png",
                width: 200,
              ),
            ),
            const SizedBox(height: 32),
            InputStyled(
              controller: email,
              prefixIcon: const Icon(Icons.mail),
              label: "Email",
              hint: "Masukkan Email",
            ),
            const SizedBox(height: 16),
            InputStyled(
              controller: password,
              prefixIcon: const Icon(Icons.lock),
              label: "Password",
              hint: "Masukkan Password",
              obscureText: !passwordVisible,
              suffixIcon: IconButton(
                icon: Icon(!passwordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
              ),
            ),
            const SizedBox(height: 22),
            BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthLoading) {
                  showDialog(
                    context: context,
                    builder: (context) => const LoadingDialog(),
                  );
                }
                if (state is AuthFailed) {
                  Navigator.pop(context);

                  showDialog(
                    context: context,
                    builder: (context) => MessageDialog(
                      status: 'Gagal',
                      message: state.message,
                      onOkPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  );
                }
                if (state is AuthSuccess) {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainApp(),
                    ),
                  );
                }
              },
              child: FilledButton(
                onPressed: () {
                  context.read<AuthCubit>().login(
                        DataLogin(
                          email: email.text,
                          password: password.text,
                        ),
                      );
                },
                child: const Text("LOGIN"),
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              "Belum punya akun?",
              textAlign: TextAlign.center,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterScreen(),
                  ),
                );
              },
              child: Text(
                "DAFTAR",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
