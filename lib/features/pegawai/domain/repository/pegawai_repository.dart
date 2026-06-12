import 'package:admin_pegawai_bloc/features/pegawai/domain/entities/pegawai_entity.dart';

abstract class PegawaiRepository {
  Future<PegawaiCountEntity> getTotalPegawai();

  Future<List<PegawaiResponseEntity>> getDataPegawai();
}
