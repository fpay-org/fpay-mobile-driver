import 'package:dio/dio.dart';
import 'package:fpay_driver/config/config.dart';
import 'package:fpay_driver/model/card.dart';
import 'package:fpay_driver/model/driver.dart';
import 'package:fpay_driver/services/payment_service.dart';
import 'package:fpay_driver/services/pref_service.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  final baseUrl = Config.baseUrl;

  Future<Driver> fetchDriver() {
    return PrefService().getToken().then((token) {
      return Dio()
          .get('$baseUrl/me/', queryParameters: {"token": token}).then((res) {
        return Driver.fromJson(res.data['data']);
      }).catchError((error) {
        Logger().i(error);
      });
    });
  }
}
