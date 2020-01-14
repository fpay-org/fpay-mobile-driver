import 'package:dio/dio.dart';
import 'package:fpay_driver/config/config.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final baseUrl = Config.baseUrl;

  

  Future<bool> login(String id, String password) {
    return Dio().get(
      //'$baseUrl/auth/driver/login?nid=961881579v&password=123'
      '$baseUrl/auth/driver/login?nid=$id&password=$password',
      //https://<baseurl>/driver/login?nid=<nid>&password=<password>
    ).then((res) async {
      if (res.statusCode == 200) {
        print(res);
        String token = res.data["data"]["token"];
        return await _saveToken(token);
      }
      return false;
    }).catchError((err) => false);
  }
  
  Future<bool> _saveToken(String token) {
    return SharedPreferences.getInstance().then((instance) {
      return instance.setString("token", token);
    });
  }

  Future<bool> logout()  async {
    //BuildContext context;
    await SharedPreferences.getInstance().then((prefs){
          prefs.remove("token");
          //Application.router.navigateTo(context,'/',clearStack: true);
          
    });
Logger().i("logout");
    return true;
  }

}

