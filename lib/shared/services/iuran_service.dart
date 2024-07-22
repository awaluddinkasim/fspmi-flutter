import 'package:fspmi/models/iuran.dart';
import 'package:fspmi/shared/utils/dio.dart';

class IuranService {
  Future<Iuran> getIuran(String token) async {
    final response = await Request.get("/iuran-user", headers: {
      'Authorization': 'Bearer $token',
    });

    return Iuran.fromJson(response['iuran']);
  }
}
