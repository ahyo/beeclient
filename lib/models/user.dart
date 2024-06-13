class User {
  String username;
  String token;
  String fullname;
  String id;

  User(
      {required this.username,
      required this.token,
      this.fullname = '',
      this.id = ''});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        username: json['client_email'],
        token: json['access_token'],
        fullname: json['client_fullname'],
        id: json['client_id']);
  }
}
