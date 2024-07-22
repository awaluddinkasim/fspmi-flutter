import 'dart:io';

class DataRegister {
  String nama;
  String email;
  String password;
  String noHp;
  String jk;
  File? ktp;
  File? foto;

  DataRegister({
    required this.nama,
    required this.email,
    required this.password,
    required this.noHp,
    required this.jk,
    this.ktp,
    this.foto,
  });
}
