import 'package:admin_pegawai_bloc/features/presensi/presentation/cubit/presensi_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PresensiScreen extends StatefulWidget {
  const PresensiScreen({super.key});

  @override
  State<PresensiScreen> createState() => _PresensiScreenState();
}

class _PresensiScreenState extends State<PresensiScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<PresensiCubit>().getDataPresensi();
      }
    });
  }

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
          BlocBuilder<PresensiCubit, PresensiState>(
            builder: (context, state) {
              if (state is PresensiLoading) {
                return Skeletonizer.sliver(
                  enabled: true,
                  child: SliverPadding(
                    padding: EdgeInsets.fromLTRB(23, 22, 23, 20),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: presensiCard(
                            nama: "joy",
                            nik: "90123123",
                            status: "masuk",
                            jamMasuk: "123123123",
                            tanggalMasuk: "joy",
                          ),
                        );
                      }, childCount: 3),
                    ),
                  ),
                );
              }

              if (state is PresensiSuccess) {
                final response = state.dataPresensi;
                final items = response.items;

                if (items.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Center(
                        child: Text("Tidak ada data pegawai pada sesi ini."),
                      ),
                    ),
                  );
                }

                final List<Map<String, dynamic>> flatListPegawai = [];

                for (var sesi in items) {
                  if (sesi.pegawai != null) {
                    for (var pegawai in sesi.pegawai!) {
                      flatListPegawai.add({
                        'nama': pegawai.name,
                        'nik': pegawai.email,
                        'status': pegawai.status,
                        'waktu': sesi.createdAt,
                      });
                    }
                  }
                }

                if (flatListPegawai.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Center(
                        child: Text("Tidak ada data pegawai pada sesi ini."),
                      ),
                    ),
                  );
                }

                return SliverPadding(
                  padding: EdgeInsets.only(top: 20, left: 23, right: 23),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final itemPegawai = flatListPegawai[index];

                      if (itemPegawai.isEmpty) return const SizedBox.shrink();
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: presensiCard(
                          nama: itemPegawai['nama'],
                          nik: itemPegawai['nik'],
                          status: itemPegawai['status'],
                          tanggalMasuk: itemPegawai['waktu'],
                          jamMasuk: itemPegawai['waktu'],
                        ),
                      );
                    }, childCount: flatListPegawai.length),
                  ),
                );
              }
              if (state is PresensiError) {
                return SliverToBoxAdapter(
                  child: Center(child: Text(state.errorMessage)),
                );
              }
              return SliverToBoxAdapter(
                child: Center(child: Text("Samting wong")),
              );
            },
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
    color: Colors.white,
    elevation: 3.0,
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
              Expanded(child: Text(nama)),
              Spacer(),
              Container(
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                  color: status == "alpha" ? Colors.red : Colors.green,
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
              Text(tanggalMasuk),
            ],
          ),
        ],
      ),
    ),
  );
}
