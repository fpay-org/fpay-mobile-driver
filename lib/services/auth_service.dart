import 'package:dio/dio.dart';
import 'package:fpay_driver/config/config.dart';
import 'package:fpay_driver/services/pref_service.dart';
import 'package:logger/logger.dart';

class AuthService {
  final baseUrl = Config.baseUrl;
  String nid;

  Future<bool> login(String id, String password) {
    return Dio()
        .get('$baseUrl/auth/driver/login?nid=$id&password=$password')
        .then((res) async {
      if (res.statusCode == 200) {
        return await PrefService().setToken(res.data['data']['token']);
      }
      return false;
    }).catchError((error) {
      Logger().e(error);
      return false;
    });
  }

  Future<bool> logout() async {
    return await PrefService().setToken(null);
  }

  Future<bool> isLoggedIn() {
    return PrefService()
        .getToken()
        .then((token) => (token != null) ? true : false)
        .catchError((error) => Logger().e(error));
  }
}
