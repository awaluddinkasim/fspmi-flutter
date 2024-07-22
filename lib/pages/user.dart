import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fspmi/cubit/auth_cubit.dart';
import 'package:fspmi/cubit/auth_state.dart';
import 'package:fspmi/pages/auth/login.dart';
import 'package:fspmi/shared/constants.dart';
import 'package:fspmi/shared/widgets/dialog/loading.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthCubit>().currentUser;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 72, horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Akun Saya",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 64),
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  "${Constants.baseUrl}/f/foto-profile/${user!.fotoProfile}",
                ),
              ),
            ),
            const SizedBox(height: 64),
            ListTile(
              title: const Text("Email"),
              subtitle: Text(user.email),
              trailing: const Icon(
                Icons.mail,
                color: Colors.grey,
              ),
            ),
            ListTile(
              title: const Text("Nama"),
              subtitle: Text(user.nama),
              trailing: const Icon(
                Icons.person,
                color: Colors.grey,
              ),
            ),
            ListTile(
              title: const Text("No. HP"),
              subtitle: Text(user.noHp),
              trailing: const Icon(
                Icons.phone,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthLoading) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const LoadingDialog(),
                  );
                }
                if (state is AuthInitial) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false,
                  );
                }
              },
              child: FilledButton(
                onPressed: () {
                  context.read<AuthCubit>().logout();
                },
                child: const Text("Logout"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
