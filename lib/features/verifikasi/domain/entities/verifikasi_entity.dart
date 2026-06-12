import 'package:admin_pegawai_bloc/features/pegawai/domain/entities/pegawai_entity.dart';

class VerifikasiEntity {
  final String id;
  final String fieldName;
  final String? oldValue;
  final String? newValue;
  final String status;
  final String employeeId;
  final PegawaiResponseEntity employee;

  VerifikasiEntity({
    required this.id,
    required this.fieldName,
    this.oldValue,
    this.newValue,
    required this.status,
    required this.employeeId,
    required this.employee,
  });
}
