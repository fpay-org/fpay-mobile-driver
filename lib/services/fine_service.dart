import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:fpay_driver/config/config.dart';
import 'package:fpay_driver/screens/home/home_screen.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

class FineService {
  final baseUrl = Config.baseUrl;

  Future<List<Fine>> getFines() async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString("token");
    // Logger().i('$token');
    return await Dio()
        .get(
      '$baseUrl/fines/driver/961881579v',
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
          Logger().i("huk    ${f["id"]}");
          Fine fine = Fine(
               f["id"],
               f["value"],
              // f["penalties"],
              // f["officer"],
              // f["scondary_officer"],
              // f["location"]["longitude"],
              // f["location"]["latitude"]
              );
          fines.add(fine);
          Logger().i("vdjskbvjkdsbvkbdskvbds");
        }

        return fines;
      }
      Logger().i("return false");
      return false;
    }).catchError((err) => false);
  }

  Future<bool> register(String fname, String lname, String email, int mobile_no,
      String licenese_id, String uName, String pass) {
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
