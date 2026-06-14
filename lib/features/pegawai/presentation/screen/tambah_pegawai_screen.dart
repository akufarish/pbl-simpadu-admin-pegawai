import 'package:admin_pegawai_bloc/core/constants/app_colors.dart';
import 'package:admin_pegawai_bloc/features/pegawai/domain/entities/pegawai_entity.dart';
import 'package:admin_pegawai_bloc/features/pegawai/presentation/cubit/pegawai_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TambahPegawaiScreen extends StatefulWidget {
  const TambahPegawaiScreen({super.key});

  @override
  State<TambahPegawaiScreen> createState() => _TambahPegawaiScreenState();
}

class _TambahPegawaiScreenState extends State<TambahPegawaiScreen> {
  final _nipController = TextEditingController();
  final _nikController = TextEditingController();
  final _employeeNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nipController.text = "198503152010211215";
    _nikController.text = "6371011503852215";
    _employeeNameController.text = "akuparisparis";
  }

  @override
  void dispose() {
    _nipController.dispose();
    _nikController.dispose();
    _employeeNameController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final payload = PegawaiRequestEntity(
        nip: _nipController.text,
        nik: _nikController.text,
        employeeName: _employeeNameController.text,
        citizenCode: "ID",
      );

      context.read<PegawaiCubit>().createPegawai(payload);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<PegawaiCubit, PegawaiState>(
        listener: (context, state) {
          if (state is PegawaiCreateSuccess) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => AlertDialog(
                icon: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 50,
                ),
                title: const Text("Data berhasil ditambahkan!"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text("Ok"),
                  ),
                ],
              ),
            );
          } else if (state is PegawaiCreateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(23, 40, 23, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Tambah Pegawai",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(29, 18, 29, 18),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          InputGroup(
                            textEditingController: _employeeNameController,
                            icon: Icons.person,
                            label: "Nama Lengkap",
                          ),
                          InputGroup(
                            textEditingController: _nipController,
                            icon: Icons.badge,
                            label: "NIP",
                          ),
                          InputGroup(
                            textEditingController: _nikController,
                            icon: Icons.credit_card,
                            label: "NIK",
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: BlocBuilder<PegawaiCubit, PegawaiState>(
                              builder: (context, state) {
                                final isLoading = state is PegawaiCreateLoading;

                                return ElevatedButton(
                                  onPressed: isLoading ? null : _submitForm,
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    backgroundColor: AppColors.primaryColor,
                                    disabledBackgroundColor: Colors.grey,
                                  ),
                                  child: isLoading
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Text(
                                          "Tambah",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 18)),
          const SizedBox(height: 10),
          TextFormField(
            controller: textEditingController,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(color: Colors.black54),
              prefixIcon: Icon(icon, color: Colors.black87),
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
