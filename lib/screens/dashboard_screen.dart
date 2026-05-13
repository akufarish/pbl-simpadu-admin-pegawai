import 'package:admin_pegawai/components/verifikasi_card_component.dart';
import 'package:admin_pegawai/models/user.dart';
import 'package:admin_pegawai/providers/user_provider.dart';
import 'package:admin_pegawai/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  late Future<UserResponse?> user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      context.read<UserProvider>().profile();
    });
  }

  void doLogout() async {
    final provider = context.read<UserProvider>();
    bool isSuccess = await provider.logout();

    if (!mounted) return;

    if (isSuccess) {
      Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Samting Wong")));
    }
  }

  final List<Map<String, String>> daftarDosen = [
    {"nama": "Dosen 1", "nik": "A01239102310293", "status": "Pending"},
    {"nama": "Dosen 2", "nik": "B01239102310294", "status": "Approved"},
    {"nama": "Dosen 3", "nik": "C01239102310295", "status": "Pending"},
    {"nama": "Dosen 4", "nik": "D01239102310296", "status": "Rejected"},
  ];

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = context.watch<UserProvider>();
    final UserResponse? user = userProvider.data;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: userProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.only(top: 48, left: 23, right: 23),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Selamat Datang, ${user?.name ?? "Admin"}",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "Lagi mau ngapain nih?",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),

                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 23, vertical: 24),
                  sliver: SliverGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.1,
                    children: [
                      CardCount(
                        icon: Icons.person,
                        label: "Total Pegawai",
                        total: 120,
                      ),
                      CardCount(
                        icon: Icons.check_circle_outline,
                        label: "Pending",
                        total: 2,
                      ),
                      CardCount(
                        icon: Icons.file_open,
                        label: "Laporan Masuk",
                        total: 10,
                      ),
                      CardCount(
                        icon: Icons.person_add_alt_1,
                        label: "Presensi",
                        total: 90,
                      ),
                    ],
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 23),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      "Data verifikasi terbaru",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),

                SliverPadding(
                  padding: EdgeInsets.fromLTRB(23, 22, 23, 20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final dosen = daftarDosen[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: VerifikasiCard(
                          nama: dosen["nama"]!,
                          nik: dosen["nik"]!,
                          status: dosen["status"]!,
                        ),
                      );
                    }, childCount: daftarDosen.length),
                  ),
                ),
              ],
            ),
    );
  }
}

class CardCount extends StatelessWidget {
  final IconData icon;
  final String label;
  final int total;

  const CardCount({
    super.key,
    required this.icon,
    required this.label,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 168,
      height: 160,
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Icon(icon, color: AppColors.primaryColor, size: 20),
              ),
            ),
            SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(label, style: TextStyle(fontSize: 14)),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(total.toString(), style: TextStyle(fontSize: 40)),
            ),
          ],
        ),
      ),
    );
  }
}
