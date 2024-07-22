class DataLogin {
  String email;
  String password;

  DataLogin({required this.email, required this.password});

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}
