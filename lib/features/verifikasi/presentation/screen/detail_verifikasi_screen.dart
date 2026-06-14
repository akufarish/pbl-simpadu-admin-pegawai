import 'package:admin_pegawai_bloc/core/constants/app_colors.dart';
import 'package:admin_pegawai_bloc/features/verifikasi/domain/entities/verifikasi_entity.dart';
import 'package:admin_pegawai_bloc/features/verifikasi/presentation/cubit/verifikasi_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailVerifikasiScreen extends StatefulWidget {
  final VerifikasiEntity verifikasiEntity;
  const DetailVerifikasiScreen({super.key, required this.verifikasiEntity});

  @override
  State<DetailVerifikasiScreen> createState() => _DetailVerifikasiScreenState();
}

class _DetailVerifikasiScreenState extends State<DetailVerifikasiScreen> {
  late String _selectedStatus;

  final List<String> _statusOptions = ['pending', 'approved', 'rejected'];

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.verifikasiEntity.status.toLowerCase();
    if (!_statusOptions.contains(_selectedStatus)) {
      _selectedStatus = 'pending';
    }
  }

  void _submitUpdate() {
    final payload = UpdateVerifikasiRequestEntity(_selectedStatus);

    context.read<VerifikasiCubit>().updateVerifikasi(
      widget.verifikasiEntity.id,
      payload,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail & Verifikasi"),
        leading: BackButton(onPressed: () => Navigator.pop(context)),
      ),

      body: BlocListener<VerifikasiCubit, VerifikasiState>(
        listener: (context, state) {
          if (state is UpdateVerifikasiSuccess) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => AlertDialog(
                icon: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 50,
                ),
                title: const Text("Status berhasil diperbarui!"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context, true);
                    },
                    child: const Text("Ok"),
                  ),
                ],
              ),
            );
          } else if (state is UpdateVerifikasiError) {
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
            padding: const EdgeInsets.fromLTRB(23, 20, 23, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(29, 18, 29, 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Data yang diubah: ${widget.verifikasiEntity.fieldName}",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 15),
                        _buildReadOnlyField(
                          label: "Old Value",
                          value: widget.verifikasiEntity.oldValue!,
                          icon: Icons.person,
                        ),
                        _buildReadOnlyField(
                          label: "New Value",
                          value: widget.verifikasiEntity.newValue!,
                          icon: Icons.badge,
                        ),

                        const Divider(height: 30, thickness: 1),

                        const Text(
                          "Status Verifikasi",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: _selectedStatus,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          items: _statusOptions.map((String status) {
                            return DropdownMenuItem<String>(
                              value: status,
                              child: Text(
                                status.toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: status == 'approved'
                                      ? Colors.green
                                      : status == 'rejected'
                                      ? Colors.red
                                      : Colors.orange,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _selectedStatus = newValue;
                              });
                            }
                          },
                        ),

                        const SizedBox(height: 30),

                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: BlocBuilder<VerifikasiCubit, VerifikasiState>(
                            builder: (context, state) {
                              final isLoading =
                                  state is UpdateVerifikasiLoading;

                              return ElevatedButton(
                                onPressed: isLoading ? null : _submitUpdate,
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
                                        "Simpan Perubahan",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                              );
                            },
                          ),
                        ),
                      ],
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

  Widget _buildReadOnlyField({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 18)),
          const SizedBox(height: 10),
          TextFormField(
            initialValue: value,
            readOnly: true,
            enabled: false,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.black38),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              fillColor: Colors.grey[100],
            ),
            style: const TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
