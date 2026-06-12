import 'package:admin_pegawai_bloc/features/pegawai/domain/entities/pegawai_entity.dart';
import 'package:admin_pegawai_bloc/features/pegawai/domain/repository/pegawai_repository.dart';

class PegawaiUsecase {
  final PegawaiRepository pegawaiRepository;

  PegawaiUsecase(this.pegawaiRepository);

  Future<List<PegawaiResponseEntity>> getDataPegawai() async {
    return pegawaiRepository.getDataPegawai();
  }

  Future<PegawaiCountEntity> getTotalPegawai() async {
    return pegawaiRepository.getTotalPegawai();
  }
}
