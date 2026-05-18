import 'package:admin_pegawai/models/verifikasi.dart';
import 'package:admin_pegawai/services/verifikasi_service.dart';
import 'package:flutter/material.dart';

class VerifikasiProvider with ChangeNotifier {
  bool isLoading = false;
  final VerifikasiService verifikasiService = VerifikasiService();
  List<VerifikasiResponse> _data = [];
  List<VerifikasiResponse> get data => _data;

  Future<void> getDataVerifikasi() async {
    isLoading = true;
    notifyListeners();
    try {
      _data = await verifikasiService.getDataVerifikasi();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      isLoading = false;
      notifyListeners();
    }
  }
}
