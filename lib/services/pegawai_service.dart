import 'dart:convert';

import 'package:admin_pegawai/models/api_response.dart';
import 'package:admin_pegawai/models/pegawai.dart';
import 'package:admin_pegawai/utils/token_manager.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PegawaiService {
  final String kelompok2Url = dotenv.get("KELOMPOK_2_BASE_URL");

  Future<bool> createPegawai(PegawaiRequest payload) async {
    try {
      String? token = await TokenManager.getAccessToken();
      debugPrint("Payload: ${payload.toJson().toString()}");

      final response = await http.post(
        Uri.parse("$kelompok2Url/api/employees"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          'ngrok-skip-browser-warning': 'true',
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',
        },
        body: jsonEncode(payload.toJson()),
      );

      final jsonResponse = jsonDecode(response.body);
      debugPrint("Hit api: $jsonResponse");

      if (response.statusCode == 201) {
        final result = ApiResponse<PegawaiResponse>.fromJson(
          jsonResponse,
          (item) => PegawaiResponse.fromJson(item),
        );
        debugPrint(result.data.toString());
        return true;
      } else {
        debugPrint("samting wong");
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
