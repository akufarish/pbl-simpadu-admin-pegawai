import 'package:admin_pegawai/components/verifikasi_card_component.dart';
import 'package:admin_pegawai/providers/verifikasi_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      context.read<VerifikasiProvider>().getDataVerifikasi();
    });
  }

  @override
  Widget build(BuildContext context) {
    final VerifikasiProvider verifikasiProvider = context
        .watch<VerifikasiProvider>();
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
            padding: EdgeInsets.fromLTRB(23, 22, 23, 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final dosen = verifikasiProvider.data[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: VerifikasiCard(
                    nama: dosen.employee.employeeName,
                    label: dosen.fieldName,
                    status: dosen.status,
                    value: dosen.newValue!,
                  ),
                );
              }, childCount: verifikasiProvider.data.length),
            ),
          ),
        ],
      ),
    );
  }
}
