import 'package:admin_pegawai/models/user.dart';
import 'package:admin_pegawai/providers/user_provider.dart';
import 'package:admin_pegawai/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UbahPassword extends StatefulWidget {
  const UbahPassword({super.key});

  @override
  State<UbahPassword> createState() => _UbahPasswordState();
}

class _UbahPasswordState extends State<UbahPassword> {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void doUpdatePassword() async {
    if (_formKey.currentState!.validate()) {
      final provider = context.read<UserProvider>();
      final email = ModalRoute.of(context)!.settings.arguments as String;

      LoginRequest loginRequest = LoginRequest(
        email: email,
        password: _passwordController.text,
      );

      bool isSuccess = await provider.updatePassword(loginRequest);

      if (!mounted) return;

      if (isSuccess) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 48, left: 23, right: 23),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _inputGroup(_passwordController, Icons.key, "Password"),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: provider.isLoading ? null : doUpdatePassword,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: AppColors.primaryColor,
                  ),
                  child: const Text(
                    "Ubah",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _inputGroup(
    TextEditingController textEditingController,
    IconData icon,
    String label,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colors.grey, fontSize: 20)),
          SizedBox(height: 15),
          TextFormField(
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Harap masukkan $label";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
