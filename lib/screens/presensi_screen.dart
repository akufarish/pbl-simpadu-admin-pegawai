import 'package:admin_pegawai/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PresensiScreen extends StatefulWidget {
  const PresensiScreen({super.key});

  @override
  State<PresensiScreen> createState() => _PresensiScreenState();
}

class _PresensiScreenState extends State<PresensiScreen> {
  final List<Map<String, String>> daftarDosen = [
    {
      "nama": "Dosen 1",
      "nik": "A01239102310293",
      "status": "Hadir",
      "jam_masuk": "13.30",
      "tanggal_masuk": DateTime.now().toString(),
    },
    {
      "nama": "Dosen 2",
      "nik": "B01239102310294",
      "status": "Hadir",
      "jam_masuk": "13.30",
      "tanggal_masuk": DateTime.now().toString(),
    },
    {
      "nama": "Dosen 3",
      "nik": "C01239102310295",
      "status": "Hadir",
      "jam_masuk": "13.30",
      "tanggal_masuk": DateTime.now().toString(),
    },
    {
      "nama": "Dosen 4",
      "nik": "D01239102310296",
      "status": "Hadir",
      "jam_masuk": "13.30",
      "tanggal_masuk": DateTime.now().toString(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(top: 48, left: 23, right: 23),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text("Presensi Pegawai")],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsetsGeometry.only(top: 20, left: 23, right: 23),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final dosen = daftarDosen[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: presensiCard(
                    nama: dosen["nama"]!,
                    nik: dosen["nik"]!,
                    status: dosen["status"]!,
                    jamMasuk: dosen["jam_masuk"]!,
                    tanggalMasuk: dosen["tanggal_masuk"]!,
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

Card presensiCard({
  required String nama,
  required String nik,
  required String status,
  required String jamMasuk,
  required String tanggalMasuk,
}) {
  return Card(
    child: Padding(
      padding: EdgeInsetsGeometry.fromLTRB(23, 14, 23, 14),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: .center,
            children: [
              Icon(Icons.account_circle, size: 42),
              SizedBox(width: 16),
              Text(nama),
              Spacer(),
              Container(
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(status, style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            crossAxisAlignment: .center,
            mainAxisAlignment: .spaceBetween,
            children: [Text("NIK"), Text(nik)],
          ),
          Divider(),
          Row(
            crossAxisAlignment: .center,
            children: [
              Icon(Icons.watch_later),
              SizedBox(width: 9),
              Text(jamMasuk),
            ],
          ),
          SizedBox(height: 14),
          Row(
            crossAxisAlignment: .center,
            children: [
              Icon(Icons.date_range),
              SizedBox(width: 9),
              Text(
                DateFormat(
                  "EEEE, MMMM d, yyyy",
                ).format(DateTime.parse(tanggalMasuk)),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
