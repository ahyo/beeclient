class Otp {
  String email;
  String authCode;
  String otp;

  Otp({required this.email, required this.authCode, required this.otp});

  factory Otp.fromJson(Map<String, dynamic> json) {
    return Otp(
        email: json['email'], authCode: json['auth_code'], otp: json['otp']);
  }
}
