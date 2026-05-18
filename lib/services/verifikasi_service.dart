import 'dart:convert';

import 'package:admin_pegawai/models/api_response.dart';
import 'package:admin_pegawai/models/verifikasi.dart';
import 'package:admin_pegawai/utils/token_manager.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class VerifikasiService {
  final String kelompok2Url = dotenv.get("KELOMPOK_2_BASE_URL");

  Future<List<VerifikasiResponse>> getDataVerifikasi() async {
    String? token = await TokenManager.getAccessToken();
    final response = await http.get(
      Uri.parse("$kelompok2Url/api/change-requests"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    final jsonResponse = jsonDecode(response.body);
    debugPrint("Data pegawai: $jsonResponse");
    final result = ApiResponse.fromJsonList<VerifikasiResponse>(
      jsonResponse,
      (e) => VerifikasiResponse.fromJson(e),
    );
    debugPrint("Data verifikasi List $result");
    return result.data!;
  }
}
