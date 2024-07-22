import 'package:dio/dio.dart';
import 'package:fspmi/models/auth.dart';
import 'package:fspmi/models/data_login.dart';
import 'package:fspmi/models/data_register.dart';
import 'package:fspmi/models/user.dart';
import 'package:fspmi/shared/utils/dio.dart';

class AuthService {
  Future<Auth> login(DataLogin data) async {
    final response = await Request.post('/login', data: data.toJson());

    final user = User.fromJson(response['user']);
    final token = response['token'];

    return Auth(token: token, user: user);
  }

  Future<void> logout({required String token}) async {
    await Request.post('/logout', headers: {
      'Authorization': 'Bearer $token',
    });
  }

  Future<String> register(DataRegister data) async {
    FormData formData = FormData.fromMap({
      'nama': data.nama,
      'email': data.email,
      'password': data.password,
      'no_hp': data.noHp,
      'jk': data.jk,
      'foto_profile': await MultipartFile.fromFile(data.foto!.path),
      'foto_ktp': await MultipartFile.fromFile(data.ktp!.path),
    });

    final response = await Request.post('/register', data: formData);

    return response['message'];
  }

  Future<Auth> getUser({required String token}) async {
    final result = await Request.get('/user', headers: {
      'Authorization': 'Bearer $token',
    });

    final user = User.fromJson(result['user']);

    return Auth(token: token, user: user);
  }
}
