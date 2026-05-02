import 'package:admin_pegawai/models/pegawai.dart';
import 'package:admin_pegawai/models/user.dart';
import 'package:admin_pegawai/services/auth_service.dart';
import 'package:admin_pegawai/services/pegawai_service.dart';
import 'package:flutter/material.dart';

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
  final _citizenCodeController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late PegawaiResponse? pegawai;
  bool isLoading = false;
  PegawaiService pegawaiService = PegawaiService();
  AuthService authService = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _nipController.text = "198503152010211212";
      _nikController.text = "6371011503852212";
      _employeeNameController.text = "akuasqolani";
      _citizenCodeController.text = "ID";
      _emailController.text = "akuasq@gmail.com";
      _passwordController.text = "adminadminadmin";
    });
  }

  void doCreatePegawai() async {
    setState(() {
      isLoading = true;
    });

    PegawaiRequest pegawaiRequest = PegawaiRequest(
      nip: _nipController.text,
      nik: _nikController.text,
      employeeName: _employeeNameController.text,
      citizenCode: _citizenCodeController.text,
    );

    pegawai = await pegawaiService.createPegawai(pegawaiRequest);

    setState(() {
      isLoading = false;
    });

    if (!mounted) return;

    if (pegawai != null) {
      RegisterRequest payload = RegisterRequest(
        name: _employeeNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        roleName: "dosen",
        detailId: pegawai!.id.toInt(),
      );
      bool isSuccess = await authService.register(payload);
      if (!mounted) return;

      if (isSuccess) {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text("Data berhasil ditambahkan!"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
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
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 120),
              Text("Login", style: TextStyle(fontSize: 34)),
              SizedBox(height: 20),
              Text(
                "Welcome back you've\n been missed!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),

              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.mail, color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: _nipController,
                  decoration: InputDecoration(
                    labelText: 'NIP',
                    labelStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.mail, color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: _nikController,
                  decoration: InputDecoration(
                    labelText: 'NIK',
                    labelStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.lock, color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: _employeeNameController,
                  decoration: InputDecoration(
                    labelText: 'Nama',
                    labelStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.lock, color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: _citizenCodeController,
                  decoration: InputDecoration(
                    labelText: 'Kewarganegaraan',
                    labelStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.lock, color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : doCreatePegawai,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      backgroundColor: Colors.blue,
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
