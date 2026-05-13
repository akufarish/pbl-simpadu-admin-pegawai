import 'package:admin_pegawai/components/card_info_component.dart';
import 'package:admin_pegawai/components/profile_card.component.dart';
import 'package:admin_pegawai/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = context.watch<UserProvider>();

    return Scaffold(
      body: userProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.fromLTRB(16, 40, 16, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Profile"),
                  SizedBox(height: 25),
                  ProfileCard(
                    userProvider.data?.name ?? "admin",
                    userProvider.data?.email ?? "admin",
                  ),
                  SizedBox(height: 35),
                  Text("Informasi Akun", style: TextStyle(fontSize: 20)),
                  SizedBox(height: 15),
                  Card(
                    elevation: 3,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsetsGeometry.fromLTRB(13, 30, 13, 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CardInfo(userProvider.data?.name ?? "Admin", "Nama:"),
                          SizedBox(height: 12),
                          Divider(),
                          SizedBox(height: 12),
                          CardInfo(
                            userProvider.data?.email ?? "Admin",
                            "Email:",
                          ),
                          Divider(),
                          SizedBox(height: 12),
                          CardInfo(
                            userProvider.data?.roleName ?? "Admin",
                            "Role:",
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: userProvider.isLoading ? null : doLogout,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(5),
                          ),
                        ),
                        child: userProvider.isLoading
                            ? CircularProgressIndicator()
                            : Text(
                                "Logout",
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
