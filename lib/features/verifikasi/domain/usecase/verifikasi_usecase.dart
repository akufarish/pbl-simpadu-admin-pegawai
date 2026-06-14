import 'package:admin_pegawai_bloc/features/verifikasi/domain/entities/verifikasi_entity.dart';
import 'package:admin_pegawai_bloc/features/verifikasi/domain/repository/verifikasi_repository.dart';

class VerifikasiUsecase {
  final VerifikasiRepository verifikasiRepository;

  VerifikasiUsecase(this.verifikasiRepository);

  Future<List<VerifikasiEntity>> getDataVerifikasi() async {
    return await verifikasiRepository.getDataVerifikasi();
  }

  Future<VerifikasiEntity> updateVerifikasi(
    String id,
    UpdateVerifikasiRequestEntity payload,
  ) async {
    return await verifikasiRepository.updateVerifikasi(id, payload);
  }

  Future<TotalVerifikasiPendingEntity> getTotalVerifikasiPending() async {
    return await verifikasiRepository.getTotalVerifikasiPending();
  }
}
