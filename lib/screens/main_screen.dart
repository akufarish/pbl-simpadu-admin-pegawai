import 'package:admin_pegawai/screens/dashboard_screen.dart';
import 'package:admin_pegawai/screens/pegawai_screen.dart';
import 'package:admin_pegawai/screens/presensi_screen.dart';
import 'package:admin_pegawai/screens/profile_screen.dart';
import 'package:admin_pegawai/screens/verifikasi_screen.dart';
import 'package:admin_pegawai/utils/app_colors.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Dashboard(),
    PegawaiScreen(),
    PresensiScreen(),
    VerifikasiScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppColors.primaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: AppColors.primaryColor),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add_alt_1, color: AppColors.primaryColor),
            label: 'Pegawai',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle, color: AppColors.primaryColor),
            label: 'Presensi',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.monitor_heart_outlined,
              color: AppColors.primaryColor,
            ),
            label: 'Verifikasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: AppColors.primaryColor),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
