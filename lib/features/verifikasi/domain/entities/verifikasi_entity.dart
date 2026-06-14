import 'package:admin_pegawai_bloc/features/pegawai/domain/entities/pegawai_entity.dart';
import 'package:admin_pegawai_bloc/features/verifikasi/data/model/verifikasi_model.dart';

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

class UpdateVerifikasiRequestEntity {
  final String status;

  UpdateVerifikasiRequestEntity(this.status);

  UpdateVerifikasiRequest toModel() {
    return UpdateVerifikasiRequest(status);
  }
}

class TotalVerifikasiPendingEntity {
  final int totalPending;

  TotalVerifikasiPendingEntity(this.totalPending);
}
