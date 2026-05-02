import 'package:admin_pegawai/screens/dashboard_screen.dart';
import 'package:admin_pegawai/screens/login_screen.dart';
import 'package:admin_pegawai/utils/token_manager.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();

  String? token = await TokenManager.getAccessToken();
  Widget screen = LoginScreen();

  if (token != null && !JwtDecoder.isExpired(token)) {
    screen = Dashboard();
  }

  runApp(MainApp(screen: screen));
}

class MainApp extends StatelessWidget {
  final Widget screen;
  const MainApp({super.key, required this.screen});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: screen),
      routes: {
        "/login": (context) => LoginScreen(),
        "/dashboard": (context) => Dashboard(),
      },
    );
  }
}
