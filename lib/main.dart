import 'package:admin_pegawai_bloc/core/di/di.dart';
import 'package:admin_pegawai_bloc/core/utils/token_manager.dart';
import 'package:admin_pegawai_bloc/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:admin_pegawai_bloc/features/auth/presentation/screen/login_screen.dart';
import 'package:admin_pegawai_bloc/features/dashboard/presentation/screen/main_screen.dart';
import 'package:admin_pegawai_bloc/features/pegawai/presentation/cubit/pegawai_cubit.dart';
import 'package:admin_pegawai_bloc/features/presensi/presentation/cubit/presensi_cubit.dart';
import 'package:admin_pegawai_bloc/features/verifikasi/presentation/cubit/verifikasi_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();

  WidgetsFlutterBinding.ensureInitialized();
  String? token = await TokenManager.getAccessToken();
  Widget screen = LoginScreen();

  if (token != null && !JwtDecoder.isExpired(token)) {
    screen = MainScreen();
  }
  setup();
  runApp(MainApp(screen: screen));
}

class MainApp extends StatelessWidget {
  final Widget screen;

  const MainApp({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => AuthCubit(getIt()),
        ),
        BlocProvider<PegawaiCubit>(
          create: (BuildContext context) => PegawaiCubit(getIt()),
        ),
        BlocProvider<VerifikasiCubit>(
          create: (BuildContext context) => VerifikasiCubit(getIt()),
        ),
        BlocProvider<PresensiCubit>(
          create: (BuildContext context) => PresensiCubit(getIt()),
        ),
      ],
      child: MaterialApp(
        home: screen,
        routes: {
          "login": (context) => LoginScreen(),
          "dashboard": (context) => MainScreen(),
        },
      ),
    );
  }
}
