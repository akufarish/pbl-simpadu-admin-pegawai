import 'package:admin_pegawai/models/user.dart';
import 'package:admin_pegawai/services/auth_service.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: DashboardPage());
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final AuthService authService = AuthService();
  late Future<UserResponse?> user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      user = authService.profile();
    });
  }

  void doLogout() async {
    bool isSuccess = await authService.logout();

    if (!mounted) return;

    if (isSuccess) {
      Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Samting Wong")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<UserResponse?>(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData && snapshot.data != null) {
            final user = snapshot.data!;
            return Padding(
              padding: EdgeInsetsGeometry.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hallo"),
                  SizedBox(height: 16),
                  Text("Name: ${user.name}"),
                  Text("Email: ${user.email}"),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/tambah-pegawai");
                    },
                    child: Text("Tambah Pegawai"),
                  ),
                  Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: doLogout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Gagal memuat data pengguna."),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: doLogout,
                    child: const Text("Logout"),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
