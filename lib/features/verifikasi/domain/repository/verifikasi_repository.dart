import 'package:admin_pegawai_bloc/features/verifikasi/domain/entities/verifikasi_entity.dart';

abstract class VerifikasiRepository {
  Future<List<VerifikasiEntity>> getDataVerifikasi();

  Future<VerifikasiEntity> updateVerifikasi(
    String id,
    UpdateVerifikasiRequestEntity payload,
  );
}
