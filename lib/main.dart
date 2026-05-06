import 'package:admin_pegawai/providers/pegawai_provider.dart';
import 'package:admin_pegawai/providers/user_provider.dart';
import 'package:admin_pegawai/screens/auth_screen.dart';
import 'package:admin_pegawai/screens/dashboard_screen.dart';
import 'package:admin_pegawai/screens/tambah_pegawai_screen.dart';
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
    screen = Dashboard();
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => PegawaiProvider()),
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
        "/dashboard": (context) => Dashboard(),
        "/tambah-pegawai": (context) => TambahPegawai(),
      },
    );
  }
}
