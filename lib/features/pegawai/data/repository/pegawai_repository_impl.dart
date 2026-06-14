import 'package:admin_pegawai_bloc/core/errors/error_handler.dart';
import 'package:admin_pegawai_bloc/features/pegawai/data/remote/pegawai_remote.dart';
import 'package:admin_pegawai_bloc/features/pegawai/domain/entities/pegawai_entity.dart';
import 'package:admin_pegawai_bloc/features/pegawai/domain/repository/pegawai_repository.dart';

class PegawaiRepositoryImpl implements PegawaiRepository {
  final PegawaiRemote pegawaiRemote;

  PegawaiRepositoryImpl(this.pegawaiRemote);

  @override
  Future<List<PegawaiResponseEntity>> getDataPegawai() async {
    try {
      final response = await pegawaiRemote.getDataPegawai();

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
  Future<PegawaiCountEntity> getTotalPegawai() async {
    try {
      final response = await pegawaiRemote.getTotalPegawai();

      return response.data!;
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  @override
  Future<PegawaiResponseEntity> createPegawai(
    PegawaiRequestEntity payload,
  ) async {
    try {
      final response = await pegawaiRemote.createPegawai(payload.toModel());
      return response.data!;
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}
