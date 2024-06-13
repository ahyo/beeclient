import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/register.dart';
import '../models/otp.dart';
import '../services/api_service.dart';

class AuthProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  User? _user;
  String? _token;
  String? get token => _token;
  User? get user => _user;

  Register? _register;
  Otp? _otp;

  Future<bool> login(String username, String password) async {
    _user = await _apiService.login(username, password);
    notifyListeners();
    return _user != null;
  }

  Future<bool> register(String fullname, String email, String phone,
      String password, String reffCode) async {
    _register =
        await _apiService.register(fullname, email, phone, password, reffCode);
    notifyListeners();
    return _register != null;
  }

  Future<bool> verifyOtp(String email, String otp) async {
    _otp = await _apiService.verifyOtp(email, otp);
    notifyListeners();
    return _otp != null;
  }

  void logout() {
    _token = null;
    notifyListeners();
  }
}
