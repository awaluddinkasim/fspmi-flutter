import 'package:fspmi/models/user.dart';

class Auth {
  String token;
  User user;

  Auth({required this.token, required this.user});

  Auth copyWith({String? token, User? user}) {
    return Auth(
      token: token ?? this.token,
      user: user ?? this.user,
    );
  }

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }
}
