import 'dart:async';
import 'package:dio/dio.dart';
import 'package:fpay_driver/config/config.dart';
import 'package:fpay_driver/model/fine.dart';
import 'package:fpay_driver/services/pref_service.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FineService {
  final baseUrl = Config.baseUrl;

  Future<List<dynamic>> fetchActiveFines() {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String nid = prefs.getString("nid");
    // Logger().i('$nid');

    return PrefService().getToken().then((token) {
      return Dio().get('$baseUrl/me/?token=$token').then((me) {
        String uri = '$baseUrl/fines/driver/${me.data['data']['nid']}';

        Logger().i(uri);

        return Dio().get(uri).then((res) {
          List<dynamic> fines =
              res.data['data'].map((fine) => Fine.fromJson(fine)).toList();

          return fines.where((fine) => !fine.isPaid).toList();
        }).catchError((error) {
          Logger().e(error);
        });
      }).catchError((error) {
        Logger().e(error);
      });
    }).catchError((error) {
      Logger().e(error);
    });
  }

  Future<List<dynamic>> fetchPaidFines() {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String nid = prefs.getString("nid");
    // Logger().i('$nid');

    return PrefService().getToken().then((token) {
      return Dio().get('$baseUrl/me/?token=$token').then((me) {
        return Dio()
            .get('$baseUrl/fines/driver/${me.data['data']['nid']}')
            .then((res) {
          List<dynamic> fines =
              res.data['data'].map((fine) => Fine.fromJson(fine)).toList();

          return fines.where((fine) => fine.isPaid).toList();
        }).catchError((error) {
          Logger().e(error);
        });
      }).catchError((error) {
        Logger().e(error);
      }).catchError((error) {
        Logger().e(error);
      });
    });
  }

  Future<bool> payFine(fineID) {
    // return Dio().get('')
    return Dio().get('$baseUrl/fines/$fineID/pay').then((res) {
      return (res.statusCode == 200) ? true : false;
    }).catchError((error) {
      Logger().e(error);
    });
  }
}
