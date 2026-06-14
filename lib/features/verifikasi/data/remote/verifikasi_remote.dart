import 'package:admin_pegawai_bloc/core/network/api_response.dart';
import 'package:admin_pegawai_bloc/features/verifikasi/data/model/verifikasi_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'verifikasi_remote.g.dart';

@RestApi()
abstract class VerifikasiRemote {
  factory VerifikasiRemote(Dio dio, {String baseUrl}) = _VerifikasiRemote;

  @GET("/api/change-requests")
  Future<ApiResponse<List<VerifikasiModel>>> getDataVerifikasi();

  @PUT("/api/change-requests/{id}")
  Future<ApiResponse<VerifikasiModel>> updateVerifikasi(
    @Path("id") String id,
    @Body() UpdateVerifikasiRequest payload,
  );
}
