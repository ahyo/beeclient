class Register {
  String fullname;
  String email;
  String phone;
  String password;
  String reffCode;

  Register(
      {required this.fullname,
      required this.email,
      required this.phone,
      required this.password,
      this.reffCode = ''});

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
        fullname: json['fullname'],
        email: json['email'],
        phone: json['phone'],
        password: json['password'],
        reffCode: json['reffCode']);
  }
}
