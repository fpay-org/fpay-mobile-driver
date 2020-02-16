import 'dart:async';
import 'package:dio/dio.dart';
import 'package:fpay_driver/config/config.dart';
import 'package:fpay_driver/model/fine.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FineService {
  final baseUrl = Config.baseUrl;

  Future<List<dynamic>> fetchActiveFines() {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String nid = prefs.getString("nid");
    // Logger().i('$nid');

    return Dio().get('$baseUrl/fines/driver/960502949v').then((res) {
      List<dynamic> fines =
          res.data['data'].map((fine) => Fine.fromJson(fine)).toList();

      return fines.where((fine) => !fine.isPaid).toList();
    }).catchError((error) {
      Logger().e(error);
    });
  }

  Future<List<dynamic>> fetchPaidFines() {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String nid = prefs.getString("nid");
    // Logger().i('$nid');

    return Dio().get('$baseUrl/fines/driver/960502949v').then((res) {
      List<dynamic> fines =
          res.data['data'].map((fine) => Fine.fromJson(fine)).toList();

      return fines.where((fine) => fine.isPaid).toList();
    }).catchError((error) {
      Logger().e(error);
    });
  }
}
