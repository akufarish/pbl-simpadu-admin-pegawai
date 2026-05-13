import 'package:admin_pegawai/components/verifikasi_card_component.dart';
import 'package:flutter/material.dart';

class VerifikasiScreen extends StatefulWidget {
  const VerifikasiScreen({super.key});

  @override
  State<VerifikasiScreen> createState() => _VerifikasiScreenState();
}

class _VerifikasiScreenState extends State<VerifikasiScreen> {
  final List<Map<String, String>> daftarDosen = [
    {"nama": "Dosen 1", "nik": "A01239102310293", "status": "Pending"},
    {"nama": "Dosen 2", "nik": "B01239102310294", "status": "Approved"},
    {"nama": "Dosen 3", "nik": "C01239102310295", "status": "Pending"},
    {"nama": "Dosen 4", "nik": "D01239102310296", "status": "Rejected"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(top: 48, left: 23, right: 23),
            sliver: SliverToBoxAdapter(
              child: Text("Verifikasi Perubahan Data"),
            ),
          ),
          SliverPadding(
            padding: EdgeInsetsGeometry.only(top: 20, left: 23, right: 23),
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
