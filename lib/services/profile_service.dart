import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fpay_driver/config/config.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Driver{
  String first_name;
  String last_name;
  String nid;
  String email;
  String license_number;
  String contact_number;
  Driver(this.first_name,this.last_name, this.nid, this.email,this.license_number, this.contact_number);

  // factory Driver.fromJson(Map<String, dynamic> json) {
  //   return Driver(
  //     name: json['first_name'],
  //     nid: json['nid'],
  //     //email: json['email'],
  //     email: "sashi@gmail.com",
  //     lno: json['licence_number'],
  //     pno: json['contact_number'],
  //   );
  // }
}
class ProfService {
  final baseUrl = Config.baseUrl;
  
  
 
  Future<Driver> getDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    //List<Driver> driverDetails = [];
    Driver driver;
    Logger().i("jblbnllnlk:::: ${token}");

   return Dio().get('$baseUrl/me?token=$token',).then((res) async {
      Logger().i("$res");
      
      if (res.statusCode == 200) {
        Logger().i("prof: ${res.data["data"]}");
        var f = res.data["data"];
        Logger().i("f: ${f["first_name"]}");
        //print(res);
        driver  = Driver(f["first_name"],f["last_name"],f["nid"],"cazci@gmail.com",f["license_number"],f["contact_number"],);
        Logger().i("d: ${driver}");
        //driver.add(driver);
        //String token = res.data["data"]["token"];
        //return driver;
        Logger().i("prof");
        return driver;
      }
    Logger().i("returned false");
      
      return driver;
    }).catchError((err){
      Logger().i(err);
       return false;
    });
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

