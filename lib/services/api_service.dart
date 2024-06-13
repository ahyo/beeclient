import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/register.dart';
import '../models/otp.dart';

class ApiService {
  final String baseUrl = 'https://beecrm.online';

  Future<User?> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'username=$username&password=$password',
      );
      if (response.statusCode == 200) {
        // print(jsonDecode(response.body));
        return User.fromJson(jsonDecode(response.body));
      } else {
        // final res = jsonDecode(response.body);
        print('Failed to login: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception occurred: $e');
      return null;
    }
  }

  Future<Register?> register(String fullname, String email, String phone,
      String password, String reffCode) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'fullname': fullname,
        'email': email,
        'phone': phone,
        'password': password,
        'reff_code': reffCode,
      }),
    );

    if (response.statusCode == 200) {
      // Assuming the response contains a token or some success message
      return Register.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<Otp?> verifyOtp(String email, String otp) async {
    final response = await http.post(
      Uri.parse('$baseUrl/verify-otp'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'otp': otp,
      }),
    );

    if (response.statusCode == 200) {
      return Otp.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
