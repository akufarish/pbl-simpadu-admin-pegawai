import 'package:admin_pegawai/components/card_info_component.dart';
import 'package:admin_pegawai/components/profile_card.component.dart';
import 'package:admin_pegawai/providers/user_provider.dart';
import 'package:admin_pegawai/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dice_bear/dice_bear.dart';

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
                  _profileCard(
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

  Card _profileCard(String nama, String email) {
    final request = DiceBearRequest(
      style: DiceBearStyle.initials,
      coreOptions: DiceBearCoreOptions(seed: nama),
    );

    Widget avatar = request.toImage(width: 80, height: 80);

    return Card(
      color: Colors.white,
      elevation: 3,
      child: Padding(
        padding: EdgeInsetsGeometry.fromLTRB(13, 17, 13, 17),
        child: Row(
          children: [
            // Icon(Icons.account_circle, size: 80),
            ClipOval(child: avatar),
            SizedBox(width: 22),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(nama), Text(email)],
              ),
            ),
            Spacer(),
            // Container(
            //   width: 50,
            //   height: 50,
            //   decoration: BoxDecoration(
            //     color: AppColors.primaryColor,
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   child: Center(child: Icon(Icons.edit, color: Colors.white)),
            // ),
            IconButton.filled(
              style: IconButton.styleFrom(
                minimumSize: Size(50, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                ),
                backgroundColor: AppColors.primaryColor,
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  "/ubah-password",
                  arguments: email,
                );
              },
              icon: Icon(Icons.edit, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
