import 'package:admin_pegawai_bloc/core/constants/app_colors.dart';
import 'package:admin_pegawai_bloc/core/components/verifikasi_card.dart';
import 'package:admin_pegawai_bloc/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:admin_pegawai_bloc/features/pegawai/presentation/cubit/pegawai_cubit.dart';
import 'package:admin_pegawai_bloc/features/presensi/presentation/cubit/presensi_cubit.dart';
import 'package:admin_pegawai_bloc/features/verifikasi/presentation/cubit/verifikasi_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<AuthCubit>().profile();
        context.read<PegawaiCubit>().getTotalPegawai();
        context.read<VerifikasiCubit>().getDataVerifikasi();
        context.read<PresensiCubit>().getTotalPresensiPegawai();
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
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (state is ProfileSuccess) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Selamat Datang, ${state.userResponseEntity.name}",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "Lagi mau ngapain nih?",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    );
                  }

                  if (state is ProfileError) {
                    return Center(child: Text(state.errorMessage));
                  }

                  return Center(child: Text("Samting wong"));
                },
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 23, vertical: 24),
            sliver: SliverGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.1,
              children: [
                BlocBuilder<PegawaiCubit, PegawaiState>(
                  builder: (context, state) {
                    if (state is PegawaiCountLoading) {
                      return Skeletonizer(
                        enabled: true,
                        child: CardCount(
                          icon: Icons.check_circle_outline,
                          label: "Pending",
                          total: 2,
                        ),
                      );
                    }

                    if (state is PegawaiCountSuccess) {
                      return CardCount(
                        icon: Icons.person,
                        label: "Total Pegawai",
                        total: state.totalPegawai.totalEmployee,
                      );
                    }

                    if (state is PegawaiCountError) {
                      return Center(child: Text(state.errorMessage));
                    }

                    return Center(child: Text("Samting wong"));
                  },
                ),
                CardCount(
                  icon: Icons.check_circle_outline,
                  label: "Pending",
                  total: 2,
                ),
                CardCount(
                  icon: Icons.file_open,
                  label: "Laporan Masuk",
                  total: 10,
                ),
                BlocBuilder<PresensiCubit, PresensiState>(
                  builder: (context, state) {
                    if (state is TotalPresensiLoading) {
                      return Skeletonizer(
                        enabled: true,
                        child: CardCount(
                          icon: Icons.check_circle_outline,
                          label: "Pending",
                          total: 2,
                        ),
                      );
                    }

                    if (state is TotalPresensiSuccess) {
                      return CardCount(
                        icon: Icons.person,
                        label: "Presensi",
                        total: state.totalPresensi,
                      );
                    }

                    if (state is TotalPresensiError) {
                      return Center(child: Text(state.errorMessage));
                    }

                    return Center(child: Text("Samting wong"));
                  },
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 23),
            sliver: SliverToBoxAdapter(
              child: Text(
                "Data verifikasi terbaru",
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),

          VerifikasiWidget(),
        ],
      ),
    );
  }
}

class VerifikasiWidget extends StatelessWidget {
  const VerifikasiWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifikasiCubit, VerifikasiState>(
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
                final dosen = state.dataVerifikasi[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: VerifikasiCard(
                    nama: dosen.employee.employeeName,
                    label: dosen.fieldName,
                    status: dosen.status,
                    value: dosen.newValue!,
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

        return SliverToBoxAdapter(child: Center(child: Text("Samting wong")));
      },
    );
  }
}

class CardCount extends StatelessWidget {
  final IconData icon;
  final String label;
  final int total;

  const CardCount({
    super.key,
    required this.icon,
    required this.label,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 168,
      height: 160,
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Icon(icon, color: AppColors.primaryColor, size: 20),
              ),
            ),
            SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(label, style: TextStyle(fontSize: 14)),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(total.toString(), style: TextStyle(fontSize: 40)),
            ),
          ],
        ),
      ),
    );
  }
}
