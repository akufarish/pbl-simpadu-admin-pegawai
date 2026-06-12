import 'package:admin_pegawai_bloc/core/components/card_info.dart';
import 'package:admin_pegawai_bloc/core/constants/app_colors.dart';
import 'package:admin_pegawai_bloc/features/pegawai/domain/entities/pegawai_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dice_bear/dice_bear.dart';

class DetailPegawaiScreen extends StatelessWidget {
  final PegawaiResponseEntity dataPegawai;
  const DetailPegawaiScreen({super.key, required this.dataPegawai});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(top: 12, left: 23, right: 23),
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
              child: _profileCard(dataPegawai.employeeName, dataPegawai.nik),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 18, left: 23, right: 23),
            sliver: SliverToBoxAdapter(
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
                              cardInfo(dataPegawai.employeeName, "Nama:"),
                              const SizedBox(height: 12),
                              const Divider(),
                              const SizedBox(height: 12),
                              cardInfo(dataPegawai.nik, "NIK:"),
                              const Divider(),
                              const SizedBox(height: 12),
                              cardInfo(dataPegawai.nip, "NIP:"),
                              const Divider(),
                              const SizedBox(height: 12),
                              cardInfo(dataPegawai.gender!, "Gender:"),
                              const Divider(),
                              const SizedBox(height: 12),
                              cardInfo(
                                dataPegawai.phoneNumber.toString(),
                                "Phone Number:",
                              ),
                              const Divider(),
                              const SizedBox(height: 12),
                              cardInfo(
                                DateFormat("EEEE, MMMM d, yyyy").format(
                                  DateTime.parse(dataPegawai.birthDate!),
                                ),
                                "Tanggal Lahir:",
                              ),
                            ]),
                            const Center(child: Text("Konten Akun")),

                            _buildTabContent([
                              cardInfo(
                                dataPegawai.city?.name ?? "kota",
                                "Kota:",
                              ),
                              const Divider(),
                              const SizedBox(height: 12),
                              cardInfo(
                                dataPegawai.province?.name ?? "provinsi",
                                "Provinsi:",
                              ),
                              const Divider(),
                              const SizedBox(height: 12),
                              cardInfo(
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
    padding: const EdgeInsets.all(15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    ),
  );
}

Widget _profileCard(String nama, String email) {
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
          ClipOval(child: avatar),
          SizedBox(width: 22),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(nama), Text(email)],
            ),
          ),
        ],
      ),
    ),
  );
}
