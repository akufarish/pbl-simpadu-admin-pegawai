import 'package:admin_pegawai_bloc/core/network/api_response.dart';
import 'package:admin_pegawai_bloc/features/pegawai/data/model/pegawai_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'pegawai_remote.g.dart';

@RestApi(baseUrl: "https://api-pegawai-4a.akufarish.my.id:1234")
abstract class PegawaiRemote {
  factory PegawaiRemote(Dio dio, {String baseUrl}) = _PegawaiRemote;

  @GET("/api/employees")
  Future<ApiResponse<List<PegawaiResponse>>> getDataPegawai();

  @GET("/api/employees/info/count")
  Future<ApiResponse<PegawaiCount>> getTotalPegawai();
}
