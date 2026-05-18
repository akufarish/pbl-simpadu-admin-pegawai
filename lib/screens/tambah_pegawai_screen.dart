import 'package:admin_pegawai/models/pegawai.dart';
import 'package:admin_pegawai/models/user.dart';
import 'package:admin_pegawai/providers/pegawai_provider.dart';
import 'package:admin_pegawai/providers/user_provider.dart';
import 'package:admin_pegawai/services/auth_service.dart';
import 'package:admin_pegawai/services/pegawai_service.dart';
import 'package:admin_pegawai/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TambahPegawai extends StatelessWidget {
  const TambahPegawai({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: TambahPegawaiForm());
  }
}

class TambahPegawaiForm extends StatefulWidget {
  const TambahPegawaiForm({super.key});

  @override
  State<TambahPegawaiForm> createState() => _TambahPegawaiFormState();
}

class _TambahPegawaiFormState extends State<TambahPegawaiForm> {
  final _nipController = TextEditingController();
  final _nikController = TextEditingController();
  final _employeeNameController = TextEditingController();
  final _passwordController = TextEditingController();
  PegawaiService pegawaiService = PegawaiService();
  AuthService authService = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _nipController.text = "198503152010211215";
      _nikController.text = "6371011503852215";
      _employeeNameController.text = "akuparisparis";
      _passwordController.text = "parisparis";
    });
  }

  void doCreatePegawai() async {
    final provider = context.read<PegawaiProvider>();
    final userProvider = context.read<UserProvider>();

    PegawaiRequest pegawaiRequest = PegawaiRequest(
      nip: _nipController.text,
      nik: _nikController.text,
      employeeName: _employeeNameController.text,
      citizenCode: "ID",
    );

    await provider.create(pegawaiRequest);

    if (!mounted) return;

    if (provider.data != null) {
      RegisterRequest payload = RegisterRequest(
        name: _employeeNameController.text,
        email: "${_nipController.text}@dosen.poliban.ac.id",
        password: _nipController.text,
        roleName: "dosen",
        detailId: provider.data!.id,
      );
      bool isSuccess = await userProvider.register(payload);
      if (!mounted) return;

      if (isSuccess) {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            icon: Icon(Icons.check_circle, color: Colors.green, size: 50),
            title: Text("Data berhasil ditambahkan!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text("Ok"),
              ),
            ],
          ),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Samting wong")));
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Samting wong")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PegawaiProvider>();

    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.fromLTRB(23, 40, 23, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Tambah Pegawai"),
            SizedBox(height: 16),
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(29, 18, 29, 18),
                child: Column(
                  children: [
                    InputGroup(
                      textEditingController: _employeeNameController,
                      icon: Icons.person,
                      label: "Nama Lengkap",
                    ),
                    InputGroup(
                      textEditingController: _nipController,
                      icon: Icons.message,
                      label: "NIP",
                    ),
                    InputGroup(
                      textEditingController: _nikController,
                      icon: Icons.message,
                      label: "NIK",
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: provider.isLoading ? null : doCreatePegawai,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InputGroup extends StatelessWidget {
  const InputGroup({
    super.key,
    required this.textEditingController,
    required this.icon,
    required this.label,
  });

  final TextEditingController textEditingController;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colors.grey, fontSize: 20)),
          SizedBox(height: 15),
          TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(color: Colors.black),
              prefixIcon: Icon(icon, color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
