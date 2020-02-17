import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fpay_driver/config/config.dart';
import 'package:fpay_driver/model/driver.dart';
import 'package:fpay_driver/services/pref_service.dart';
import 'package:logger/logger.dart';

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

  Future<bool> updateProfile(File image) async {
    FormData _data = FormData.fromMap({
      "driver_image":
          await MultipartFile.fromFile(image.path, filename: "test"),
    });

    return Dio()
        .post('$baseUrl/driver/961881579v/avatar', data: _data)
        .then((res) {
      if (res.statusCode == 202) return true;
      return false;
    }).catchError((error) {
      Logger().e(error);
      return false;
    });
  }
}
