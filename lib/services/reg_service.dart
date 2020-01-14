import 'package:dio/dio.dart';
import 'package:fpay_driver/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegService {
  final baseUrl = Config.baseUrl;


Future<bool> register(String fname, String lname,String email,int mobile_no,String licenese_id,String uName,String pass ) {
    return Dio().post(
      '$baseUrl/auth/driver/register',
      data: {

        "username": uName,
        "password": pass,
        "first_name":fname,
        "last_name":lname,
        "email":email,
        "contact_number":mobile_no,
        "licence_id":licenese_id
      },
    ).then((res) async {
      if (res.statusCode == 200) {
        print(res);
        String token = res.data["data"]["token"];
        return await _saveToken(token);
      }
      //else if(res.statusCode==){} for other instances
      return false;
    }).catchError((err) => false);
  }

  Future<bool> _saveToken(String token) async {
    return await SharedPreferences.getInstance().then((instance) {
      //Logger().i('$token');
      print(token);
      instance.setString("token", token);
      return true;
    }).catchError((err) => false);
  }

}