import 'package:admin_pegawai/components/card_info_component.dart';
import 'package:admin_pegawai/components/profile_card.component.dart';
import 'package:admin_pegawai/models/pegawai.dart';
import 'package:admin_pegawai/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailPegawaiScreen extends StatelessWidget {
  final PegawaiResponse dataPegawai;
  const DetailPegawaiScreen({super.key, required this.dataPegawai});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(top: 48, left: 23, right: 23),
            sliver: SliverToBoxAdapter(child: Text("Detail Pegawai")),
          ),
          SliverPadding(
            padding: EdgeInsetsGeometry.only(
              top: 14,
              right: 23,
              left: 23,
              bottom: 14,
            ),
            sliver: SliverToBoxAdapter(
              child: ProfileCard(dataPegawai.employeeName, dataPegawai.nik),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 18, left: 23, right: 23),
            sliver: SliverToBoxAdapter(
              // Tambahkan ini sebagai pembungkus
              child: Card(
                color: Colors.white,
                elevation: 3,
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      TabBar(
                        tabAlignment: TabAlignment.start,
                        isScrollable: true,
                        labelColor: AppColors.primaryColor,
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          Tab(text: "Informasi Umum"),
                          Tab(text: "Informasi akun"),
                          Tab(text: "Domisili"),
                        ],
                      ),
                      SizedBox(
                        height: 700,
                        child: TabBarView(
                          children: [
                            _buildTabContent([
                              CardInfo(dataPegawai.employeeName, "Nama:"),
                              const SizedBox(height: 12),
                              const Divider(),
                              const SizedBox(height: 12),
                              CardInfo(dataPegawai.nik, "NIK:"),
                              const Divider(),
                              const SizedBox(height: 12),
                              CardInfo(dataPegawai.nip, "NIP:"),
                              const Divider(),
                              const SizedBox(height: 12),
                              CardInfo(dataPegawai.gender!, "Gender:"),
                              const Divider(),
                              const SizedBox(height: 12),
                              CardInfo(
                                dataPegawai.phoneNumber.toString(),
                                "Phone Number:",
                              ),
                              const Divider(),
                              const SizedBox(height: 12),
                              CardInfo(
                                DateFormat("EEEE, MMMM d, yyyy").format(
                                  DateTime.parse(dataPegawai.birthDate!),
                                ),
                                "Tanggal Lahir:",
                              ),
                            ]),
                            const Center(child: Text("Konten Akun")),

                            _buildTabContent([
                              CardInfo(
                                dataPegawai.city?.name ?? "kota",
                                "Kota:",
                              ),
                              const Divider(),
                              const SizedBox(height: 12),
                              CardInfo(
                                dataPegawai.province?.name ?? "provinsi",
                                "Provinsi:",
                              ),
                              const Divider(),
                              const SizedBox(height: 12),
                              CardInfo(
                                dataPegawai.province?.name ?? "provinsi",
                                "Provinsi:",
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildTabContent(List<Widget> children) {
  return SingleChildScrollView(
    // Mencegah Overflow saat konten panjang
    padding: const EdgeInsets.all(15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    ),
  );
}
