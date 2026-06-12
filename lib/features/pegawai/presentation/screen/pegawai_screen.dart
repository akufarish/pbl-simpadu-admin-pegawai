import 'package:admin_pegawai_bloc/core/constants/app_colors.dart';
import 'package:admin_pegawai_bloc/features/pegawai/data/model/pegawai_model.dart';
import 'package:admin_pegawai_bloc/features/pegawai/domain/entities/pegawai_entity.dart';
import 'package:admin_pegawai_bloc/features/pegawai/presentation/cubit/pegawai_cubit.dart';
import 'package:admin_pegawai_bloc/features/pegawai/presentation/screen/detail_pegawai_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PegawaiScreen extends StatefulWidget {
  const PegawaiScreen({super.key});

  @override
  State<PegawaiScreen> createState() => _PegawaiScreenState();
}

class _PegawaiScreenState extends State<PegawaiScreen> {
  List<PegawaiResponse> foundPegawai = [];
  String _searchQuery = "";

  void _onSearch(String query) {
    context.read<PegawaiCubit>().searchPegawai(query);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<PegawaiCubit>().getDataPegawai();
      }
    });
  }

  void _showModal() {
    showModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
      context: context,
      backgroundColor: AppColors.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SizedBox(child: SearchForm(onSearch: _onSearch)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(top: 48, left: 23, right: 23),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Pegawai",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/tambah-pegawai");
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: AppColors.primaryColor,
                          ),
                          child: const Text(
                            "Tambah",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (_searchQuery.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Hasil pencarian untuk: \"$_searchQuery\"",
                            style: const TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _searchQuery = "";
                              foundPegawai = [];
                            });
                          },
                          child: const Text("Hapus"),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          BlocBuilder<PegawaiCubit, PegawaiState>(
            builder: (context, state) {
              if (state is PegawaiLoading) {
                return Skeletonizer.sliver(
                  enabled: true,
                  child: SliverPadding(
                    padding: EdgeInsets.fromLTRB(23, 22, 23, 20),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: PegawaiCard(
                            item: PegawaiResponseEntity(
                              id: "1",
                              nip: "1",
                              nik: "1",
                              employeeName: "joy",
                            ),
                          ),
                        );
                      }, childCount: 3),
                    ),
                  ),
                );
              }
              if (state is PegawaiError) {
                return SliverToBoxAdapter(child: Text(state.errorMessage));
              }

              if (state is PegawaiSuccess) {
                final listPegawai = state.foundPegawai;

                if (listPegawai.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Center(child: Text("Pegawai tidak ditemukan")),
                  );
                }

                return SliverPadding(
                  padding: EdgeInsets.only(top: 20, left: 23, right: 23),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final pegawai = listPegawai[index];
                      return PegawaiCard(item: pegawai);
                    }, childCount: listPegawai.length),
                  ),
                );
              }
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showModal,
        backgroundColor: AppColors.tertiaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(50),
        ),
        child: Icon(Icons.search),
      ),
    );
  }
}

class PegawaiCard extends StatelessWidget {
  const PegawaiCard({super.key, required this.item});

  final PegawaiResponseEntity item;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailPegawaiScreen(dataPegawai: item),
                    ),
                  );
                },
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

class SearchForm extends StatefulWidget {
  final Function(String) onSearch;
  const SearchForm({super.key, required this.onSearch});

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final _namaController = TextEditingController();

  void doSearch() {
    widget.onSearch(_namaController.text);
  }

  @override
  void dispose() {
    _namaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(23.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Cari Pegawai",
              style: TextStyle(fontSize: 20, color: AppColors.primaryColor),
            ),
            SizedBox(height: 19),
            TextField(
              controller: _namaController,
              decoration: InputDecoration(
                labelText: 'Nama Lengkap',
                labelStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(Icons.person, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 19),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: doSearch,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: AppColors.primaryColor,
                ),
                child: const Text(
                  "Cari",
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
