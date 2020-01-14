import 'package:dio/dio.dart';
import 'package:fpay_driver/config/config.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfService {
  final baseUrl = Config.baseUrl;

  

  Future<List> getDetails() async {
    String token = _getToken() as String;
    return Dio().get(
      '$baseUrl/me?token=$token'
    ).then((res) async {
      if (res.statusCode == 200) {
        List details = res.data["data"];
        print(res);
        //String token = res.data["data"]["token"];
        return details;
      }
      return false;
    }).catchError((err) => false);
  }
  
  Future<bool> _saveToken(String token) {
    return SharedPreferences.getInstance().then((instance) {
      return instance.setString("token", token);
    });
  }

  Future <String> _getToken(){
    return SharedPreferences.getInstance().then((instance) {
      return instance.getString("token");
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

