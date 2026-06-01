import 'package:admin_pegawai/models/pegawai.dart';
import 'package:admin_pegawai/services/pegawai_service.dart';
import 'package:flutter/material.dart';

class PegawaiProvider with ChangeNotifier {
  bool isLoading = false;
  final PegawaiService pegawaiService = PegawaiService();
  PegawaiResponse? _data;

  PegawaiResponse? get data => _data;

  List<PegawaiResponse> _dataPegawai = [];

  List<PegawaiResponse> get dataPegawai => _dataPegawai;

  PegawaiCount _pegawaiCount = PegawaiCount(totalEmployee: 0);

  PegawaiCount get pegawaiCount => _pegawaiCount;

  Future<bool> create(PegawaiRequest payload) async {
    isLoading = true;
    notifyListeners();
    try {
      _data = await pegawaiService.createPegawai(payload);
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint("$e");
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> getDataPegawai() async {
    isLoading = true;
    notifyListeners();
    try {
      _dataPegawai = await pegawaiService.getDataPegawai();
      debugPrint("hasil pegawai: $_dataPegawai");
      isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      isLoading = false;
      notifyListeners();
    }
  }

  Future<PegawaiCount> getTotalPegawai() async {
    isLoading = true;
    notifyListeners();
    try {
      _pegawaiCount = await pegawaiService.getTotalPegawai();
      isLoading = false;
      notifyListeners();
      return _pegawaiCount;
    } catch (e) {
      debugPrint(e.toString());
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
}
