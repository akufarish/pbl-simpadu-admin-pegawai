import 'package:admin_pegawai/providers/pegawai_provider.dart';
import 'package:admin_pegawai/providers/user_provider.dart';
import 'package:admin_pegawai/providers/verifikasi_provider.dart';
import 'package:admin_pegawai/screens/auth_screen.dart';
import 'package:admin_pegawai/screens/main_screen.dart';
import 'package:admin_pegawai/screens/tambah_pegawai_screen.dart';
import 'package:admin_pegawai/screens/ubah_password.dart';
import 'package:admin_pegawai/utils/token_manager.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();

  String? token = await TokenManager.getAccessToken();
  Widget screen = AuthScreen();

  if (token != null && !JwtDecoder.isExpired(token)) {
    screen = MainScreen();
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => PegawaiProvider()),
        ChangeNotifierProvider(create: (_) => VerifikasiProvider()),
      ],
      child: MainApp(screen: screen),
    ),
  );
}

class MainApp extends StatelessWidget {
  final Widget screen;
  const MainApp({super.key, required this.screen});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: screen),
      routes: {
        "/login": (context) => AuthScreen(),
        "/dashboard": (context) => MainScreen(),
        "/tambah-pegawai": (context) => TambahPegawai(),
        "/ubah-password": (context) => UbahPassword(),
      },
    );
  }
}
