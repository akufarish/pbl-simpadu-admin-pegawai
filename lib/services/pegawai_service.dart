import 'package:admin_pegawai/models/api_response.dart';
import 'package:admin_pegawai/models/pegawai.dart';
import 'package:admin_pegawai/utils/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PegawaiService {
  final String kelompok2Url = dotenv.get("KELOMPOK_2_BASE_URL");

  Future<PegawaiResponse?> createPegawai(PegawaiRequest payload) async {
    try {
      final response = await ApiClient().dio.post(
        "$kelompok2Url/api/employees",
        data: payload.toJson(),
      );

      debugPrint("Hit api: ${response.data}");

      if (response.statusCode == 201) {
        final result = ApiResponse<PegawaiResponse>.fromJson(
          response.data,
          (item) => PegawaiResponse.fromJson(item as Map<String, dynamic>),
        );
        debugPrint(result.data.toString());
        return result.data;
      } else {
        debugPrint("samting wong");
        return null;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        try {
          final errorResult = ApiResponse<dynamic>.fromJson(
            e.response!.data,
            (item) => item,
          );

          debugPrint(errorResult.error ?? errorResult.message);
          return null;
        } catch (_) {
          debugPrint(
            "Terjadi kesalahan pada server (${e.response?.statusCode})",
          );
          return null;
        }
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<List<PegawaiResponse>> getDataPegawai() async {
    final response = await ApiClient().dio.get("$kelompok2Url/api/employees");
    debugPrint("halo dunia");
    debugPrint("Data hasil pegawai: ${response.data}");
    try {
      if (response.statusCode == 200) {
        final result = ApiResponse<List<PegawaiResponse>>.fromJson(
          response.data,
          (json) => (json as List)
              .map(
                (item) =>
                    PegawaiResponse.fromJson(item as Map<String, dynamic>),
              )
              .toList(),
        );
        return result.data!;
      } else {
        throw Exception('samting wong');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
