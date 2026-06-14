import 'package:admin_pegawai_bloc/core/errors/error_handler.dart';
import 'package:admin_pegawai_bloc/features/presensi/data/remote/presensi_remote.dart';
import 'package:admin_pegawai_bloc/features/presensi/domain/entities/presensi_entity.dart';
import 'package:admin_pegawai_bloc/features/presensi/domain/repository/presensi_repository.dart';

class PresensiRepositoryImpl implements PresensiRepository {
  final PresensiRemote presensiRemote;

  PresensiRepositoryImpl(this.presensiRemote);

  @override
  Future<PresensiResponseEntity> getDataPresensi() async {
    try {
      final response = await presensiRemote.getDataPresensi();

      if (response.data != null) {
        return response.data!;
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  @override
  Future<int> getTotalPresensiPegawai() async {
    try {
      final response = await presensiRemote.getTotalPresensiPegawai();
      if (response.data != null) {
        return response.data!;
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}
