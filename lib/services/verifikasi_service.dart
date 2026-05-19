import 'package:admin_pegawai/models/api_response.dart';
import 'package:admin_pegawai/models/verifikasi.dart';
import 'package:admin_pegawai/utils/api_client.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class VerifikasiService {
  final String kelompok2Url = dotenv.get("KELOMPOK_2_BASE_URL");

  Future<List<VerifikasiResponse>> getDataVerifikasi() async {
    final response = await ApiClient().dio.get(
      "$kelompok2Url/api/change-requests",
    );
    final result = ApiResponse<List<VerifikasiResponse>>.fromJson(
      response.data,
      (json) => (json as List)
          .map(
            (item) => VerifikasiResponse.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
    debugPrint("Data verifikasi List $result");
    return result.data!;
  }
}
