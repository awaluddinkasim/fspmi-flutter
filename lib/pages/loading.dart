import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fspmi/cubit/auth_cubit.dart';
import 'package:fspmi/cubit/auth_state.dart';
import 'package:fspmi/pages/app.dart';
import 'package:fspmi/pages/auth/login.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Future.delayed(Duration.zero, () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainApp(),
                ),
                (route) => false,
              );
            });
          } else {
            Future.delayed(Duration.zero, () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false,
              );
            });
          }
        },
        builder: (context, state) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
