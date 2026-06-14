import 'package:admin_pegawai_bloc/features/presensi/domain/entities/presensi_entity.dart';
import 'package:admin_pegawai_bloc/features/presensi/domain/repository/presensi_repository.dart';

class PresensiUsecase {
  final PresensiRepository presensiRepository;

  PresensiUsecase(this.presensiRepository);

  Future<PresensiResponseEntity> getDataPresensi() async {
    return presensiRepository.getDataPresensi();
  }

  Future<int> getTotalPresensiPegawai() async {
    return presensiRepository.getTotalPresensiPegawai();
  }
}
