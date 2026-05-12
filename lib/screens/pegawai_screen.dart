import 'package:admin_pegawai/models/pegawai.dart';
import 'package:admin_pegawai/providers/pegawai_provider.dart';
import 'package:admin_pegawai/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PegawaiScreen extends StatefulWidget {
  const PegawaiScreen({super.key});

  @override
  State<PegawaiScreen> createState() => _PegawaiScreenState();
}

class _PegawaiScreenState extends State<PegawaiScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PegawaiProvider>().getDataPegawai();
    });
  }

  @override
  Widget build(BuildContext context) {
    final PegawaiProvider pegawaiProvider = context.watch<PegawaiProvider>();
    return Scaffold(
      body: pegawaiProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.only(top: 48, left: 23, right: 23),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Pegawai"),
                        SizedBox(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(10),
                              ),
                              backgroundColor: AppColors.primaryColor,
                            ),
                            child: Text(
                              "Tambah",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsetsGeometry.only(
                    top: 20,
                    left: 23,
                    right: 23,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final dosen = pegawaiProvider.dataPegawai[index];
                      return Padding(
                        padding: EdgeInsetsGeometry.only(bottom: 16),
                        child: PegawaiCard(item: dosen),
                      );
                    }, childCount: pegawaiProvider.dataPegawai.length),
                  ),
                ),
              ],
            ),
    );
  }
}

class PegawaiCard extends StatelessWidget {
  const PegawaiCard({super.key, required this.item});

  final PegawaiResponse item;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsetsGeometry.only(
          top: 14,
          left: 23,
          right: 23,
          bottom: 20,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.account_circle, size: 42),
                SizedBox(width: 10),
                Text(item.employeeName),
              ],
            ),
            Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Text("NIK"), Spacer(), Text(item.nik)],
            ),
            Divider(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10),
                  ),
                ),
                child: Text(
                  "View Details",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
