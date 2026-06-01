import 'package:admin_pegawai/models/pegawai.dart';
import 'package:admin_pegawai/providers/pegawai_provider.dart';
import 'package:admin_pegawai/screens/detail_pegawai_screen.dart';
import 'package:admin_pegawai/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PegawaiScreen extends StatefulWidget {
  const PegawaiScreen({super.key});

  @override
  State<PegawaiScreen> createState() => _PegawaiScreenState();
}

class _PegawaiScreenState extends State<PegawaiScreen> {
  List<PegawaiResponse> foundPegawai = [];
  String _searchQuery = "";

  void _onSearch(String query) {
    setState(() {
      _searchQuery = query;
      foundPegawai = context
          .read<PegawaiProvider>()
          .dataPegawai
          .where(
            (p) => p.employeeName.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PegawaiProvider>().getDataPegawai();
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
    final PegawaiProvider pegawaiProvider = context.watch<PegawaiProvider>();
    final displayList = _searchQuery.isEmpty
        ? pegawaiProvider.dataPegawai
        : foundPegawai;

    return Scaffold(
      body: pegawaiProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
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
                                  Navigator.pushNamed(
                                    context,
                                    "/tambah-pegawai",
                                  );
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
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                  ),
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
                if (displayList.isEmpty && _searchQuery.isNotEmpty)
                  const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text("Pegawai tidak ditemukan"),
                      ),
                    ),
                  ),
                SliverPadding(
                  padding: const EdgeInsets.only(top: 20, left: 23, right: 23),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final dosen = displayList[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: PegawaiCard(item: dosen),
                      );
                    }, childCount: displayList.length),
                  ),
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

  final PegawaiResponse item;

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
