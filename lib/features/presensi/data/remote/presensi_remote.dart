import 'package:admin_pegawai_bloc/core/network/api_response.dart';
import 'package:admin_pegawai_bloc/features/presensi/data/model/presensi_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'presensi_remote.g.dart';

@RestApi()
abstract class PresensiRemote {
  factory PresensiRemote(Dio dio, {String baseUrl}) = _PresensiRemote;

  @GET("/api/presensi/pegawai")
  Future<ApiResponse<PresensiResponse>> getDataPresensi();
}
