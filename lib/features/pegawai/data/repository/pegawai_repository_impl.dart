import 'dart:convert';
import 'package:admin_pegawai_bloc/core/errors/error_handler.dart';
import 'package:admin_pegawai_bloc/features/pegawai/data/remote/pegawai_remote.dart';
import 'package:admin_pegawai_bloc/features/pegawai/domain/entities/pegawai_entity.dart';
import 'package:admin_pegawai_bloc/features/pegawai/domain/repository/pegawai_repository.dart';
import 'package:dio/dio.dart';

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
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        try {
          final responseData = e.response!.data;
          Map<String, dynamic> jsonMap;

          if (responseData is String) {
            jsonMap = jsonDecode(responseData) as Map<String, dynamic>;
          } else {
            jsonMap = Map<String, dynamic>.from(responseData as Map);
          }

          if (jsonMap['errors'] != null && jsonMap['errors'] is Map) {
            final errorsMap = jsonMap['errors'] as Map<String, dynamic>;
            List<String> allErrors = [];

            errorsMap.forEach((key, value) {
              if (value is List) {
                allErrors.add(value.join(', '));
              } else {
                allErrors.add(value.toString());
              }
            });

            if (allErrors.isNotEmpty) {
              throw Exception(allErrors.join('\n'));
            }
          }

          final String finalMessage =
              jsonMap['message']?.toString() ??
              jsonMap['error']?.toString() ??
              "Terjadi kesalahan validasi.";
          throw Exception(finalMessage);
        } catch (parseError) {
          if (parseError is Exception) rethrow;
          throw Exception("Gagal membaca format error server.");
        }
      }
      throw Exception(e.message ?? "Terjadi kesalahan jaringan.");
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}
