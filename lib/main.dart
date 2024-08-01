import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fspmi/cubit/auth_cubit.dart';
import 'package:fspmi/cubit/iuran_cubit.dart';
import 'package:fspmi/cubit/pengaduan_cubit.dart';
import 'package:fspmi/cubit/register_cubit.dart';
import 'package:fspmi/pages/loading.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Remove this method to stop OneSignal Debugging
  // OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize("e76b8dcb-5edf-4fa6-8795-3aa30f88d30e");

  // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.Notifications.requestPermission(true);

  await initializeDateFormatting('id_ID', null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => IuranCubit()),
        BlocProvider(create: (context) => PengaduanCubit()),
      ],
      child: MaterialApp(
        title: 'Federasi Pekerja Metal Indonesia',
        theme: ThemeData(
          colorScheme: ColorScheme.light(primary: Colors.blue.shade800),
          useMaterial3: true,
        ),
        home: const LoadingScreen(),
      ),
    );
  }
}
