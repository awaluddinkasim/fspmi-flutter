class User {
  String nama;
  String email;
  String noHp;
  String jk;
  String fotoProfile;

  User({
    required this.nama,
    required this.email,
    required this.noHp,
    required this.jk,
    required this.fotoProfile,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      nama: json['nama'],
      email: json['email'],
      noHp: json['no_hp'],
      jk: json['jk'],
      fotoProfile: json['foto_profile'],
    );
  }
}
