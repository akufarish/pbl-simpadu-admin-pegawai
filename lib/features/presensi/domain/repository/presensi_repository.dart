import 'package:admin_pegawai_bloc/features/presensi/domain/entities/presensi_entity.dart';

abstract class PresensiRepository {
  Future<PresensiResponseEntity> getDataPresensi();
}
