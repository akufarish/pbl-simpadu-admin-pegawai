import 'package:admin_pegawai/providers/pegawai_provider.dart';
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
          : ListView.builder(
              itemCount: pegawaiProvider.dataPegawai.length,
              itemBuilder: (context, index) {
                final item = pegawaiProvider.dataPegawai[index];

                return Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: Icon(Icons.person),
                    title: Text(item.employeeName),
                  ),
                );
              },
            ),
    );
  }
}
