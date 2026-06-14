import 'package:admin_pegawai_bloc/core/errors/error_handler.dart';
import 'package:admin_pegawai_bloc/features/verifikasi/data/remote/verifikasi_remote.dart';
import 'package:admin_pegawai_bloc/features/verifikasi/domain/entities/verifikasi_entity.dart';
import 'package:admin_pegawai_bloc/features/verifikasi/domain/repository/verifikasi_repository.dart';

class VerifikasiRepositoryImpl implements VerifikasiRepository {
  final VerifikasiRemote verifikasiRemote;

  VerifikasiRepositoryImpl(this.verifikasiRemote);

  @override
  Future<List<VerifikasiEntity>> getDataVerifikasi() async {
    try {
      final response = await verifikasiRemote.getDataVerifikasi();

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
  Future<VerifikasiEntity> updateVerifikasi(
    String id,
    UpdateVerifikasiRequestEntity payload,
  ) async {
    try {
      final response = await verifikasiRemote.updateVerifikasi(
        id,
        payload.toModel(),
      );

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
  Future<TotalVerifikasiPendingEntity> getTotalVerifikasiPending() async {
    try {
      final response = await verifikasiRemote.getTotalVerifikasiPending();
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
