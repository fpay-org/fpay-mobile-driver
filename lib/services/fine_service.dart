import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:fpay_driver/config/config.dart';
import 'package:fpay_driver/screens/home/home_screen.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class Fine {
//   final String value;
//   final String id;
//   //final String title;
//   //final String body;

//   Fine({this.id, this.value});

//   // factory Post.fromJson(Map<String, dynamic> json) {
//   //   return Post(
//   //     userId: json['userId'],
//   //     id: json['id'],
//   //     title: json['title'],
//   //     body: json['body'],
//   //   );
//   // }
// }
class Fine{
  String fineId;
  int fineValue;
  bool isPaid;
  Fine(this.fineId,this.fineValue,this.isPaid);
  
}


class FineService {
  final baseUrl = Config.baseUrl;
  
  Future<List<Fine>> getFines() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String nid = prefs.getString("nid");
    Logger().i('$nid');
    return await Dio().get(
      '$baseUrl/fines/driver/960502949v',
    )
      .then((res) async {
      Logger().i("$res");
      List<Fine> fines = [];
      Logger().i("here: ${res.data["data"]}");
      int length = res.data["data"].length;
      if (res.statusCode == 200) {
        Logger().i("$length");
        //Logger().i("nlknklnlk${res.data["data"]["fines"]}");
        Logger().i("vdjskbvjkdsbvkbdskvbds");
        
        //List<Fine> e_fines = [];
        for (int i = 0; i < length; i++) {
          var f = res.data["data"][i];
          Logger().i("huk    ${f["_id"]}");
          Logger().i("here");
          Fine fine = Fine(f["_id"],f["total_value"],f["is_payed"]);//need to add other parameters
          fines.add(fine);
          Logger().i("safaf0{$fines.length}");

        }

        return fines;
      }
      Logger().i("return false");
      return false;
    }).catchError((err) => false);
  }

  Future<bool> register(String fname, String lname, String email, int mobile_no,String licenese_id, String uName, String pass) {
    return Dio().post(
      '$baseUrl/auth/driver/register',
      data: {
        "username": uName,
        "password": pass,
        "first_name": fname,
        "last_name": lname,
        "email": email,
        "contact_number": mobile_no,
        "licence_id": licenese_id
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
 