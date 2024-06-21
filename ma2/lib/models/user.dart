// lib/models/user.dart

class User {
  String username;
  String password;
  String email;

  User(this.username, this.password, this.email);

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map['username'],
      map['password'],
      map['email'],
    );
  }
}
