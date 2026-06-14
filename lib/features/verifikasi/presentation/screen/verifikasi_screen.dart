import 'package:admin_pegawai_bloc/core/components/verifikasi_card.dart';
import 'package:admin_pegawai_bloc/features/verifikasi/domain/entities/verifikasi_entity.dart';
import 'package:admin_pegawai_bloc/features/verifikasi/presentation/cubit/verifikasi_cubit.dart';
import 'package:admin_pegawai_bloc/features/verifikasi/presentation/screen/detail_verifikasi_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class VerifikasiScreen extends StatefulWidget {
  const VerifikasiScreen({super.key});

  @override
  State<VerifikasiScreen> createState() => _VerifikasiScreenState();
}

class _VerifikasiScreenState extends State<VerifikasiScreen> {
  void _goToDetail(VerifikasiEntity data) async {
    final shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailVerifikasiScreen(verifikasiEntity: data),
      ),
    );

    if (shouldRefresh == true && mounted) {
      context.read<VerifikasiCubit>().getDataVerifikasi();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<VerifikasiCubit>().getDataVerifikasi();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.only(top: 48, left: 23, right: 23),
          sliver: SliverToBoxAdapter(child: Text("Verifikasi Perubahan Data")),
        ),

        BlocBuilder<VerifikasiCubit, VerifikasiState>(
          builder: (context, state) {
            if (state is VerifikasiLoading) {
              return Skeletonizer.sliver(
                enabled: true,
                child: SliverPadding(
                  padding: EdgeInsets.fromLTRB(23, 22, 23, 20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: VerifikasiCard(
                          nama: "joy",
                          label: "joy",
                          status: "joy",
                          value: "joy",
                        ),
                      );
                    }, childCount: 3),
                  ),
                ),
              );
            }

            if (state is VerifikasiSuccess) {
              if (state.dataVerifikasi.isEmpty) {
                return SliverToBoxAdapter(
                  child: Center(child: Text("Data Kosong")),
                );
              }

              return SliverPadding(
                padding: EdgeInsets.fromLTRB(23, 22, 23, 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final verifikasi = state.dataVerifikasi[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: InkWell(
                        onTap: () => _goToDetail(verifikasi),
                        child: VerifikasiCard(
                          nama: verifikasi.employee.employeeName,
                          label: verifikasi.fieldName,
                          status: verifikasi.status,
                          value: verifikasi.newValue!,
                        ),
                      ),
                    );
                  }, childCount: state.dataVerifikasi.length),
                ),
              );
            }

            if (state is VerifikasiError) {
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
    );
  }
}
