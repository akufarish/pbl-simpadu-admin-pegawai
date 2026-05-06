import 'package:admin_pegawai/models/user.dart';
import 'package:admin_pegawai/services/auth_service.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  final AuthService authService = AuthService();
  bool isLoading = false;

  Future<bool> login(LoginRequest payload) async {
    isLoading = true;
    notifyListeners();
    try {
      bool isSuccess = await authService.login(payload);
      isLoading = false;
      notifyListeners();
      return isSuccess;
    } catch (e) {
      debugPrint("$e");
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(RegisterRequest payload) async {
    isLoading = true;
    notifyListeners();
    try {
      bool isSuccess = await authService.register(payload);
      isLoading = false;
      notifyListeners();
      return isSuccess;
    } catch (e) {
      debugPrint("$e");
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> logout() async {
    isLoading = false;
    notifyListeners();
    try {
      bool isSuccess = await authService.logout();
      isLoading = false;
      notifyListeners();
      return isSuccess;
    } catch (e) {
      debugPrint("$e");
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
