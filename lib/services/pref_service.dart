import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  Future<bool> setToken(String token) {
    return SharedPreferences.getInstance()
        .then((instance) => instance
            .setString("token", token)
            .then((success) => true)
            .catchError((onError) => false))
        .catchError((error) {
      Logger().e(error);
      return false;
    });
  }

  Future<String> getToken() {
    return SharedPreferences.getInstance()
        .then((instance) => instance.getString("token"))
        .catchError((error) => Logger().e(error));
  }

  Future<bool> setPaymentStatus(bool state) {
    return SharedPreferences.getInstance()
        .then((instance) => instance
            .setBool("isPaymentConfigured", state)
            .then((success) => true)
            .catchError((onError) => false))
        .catchError((error) {
      Logger().e(error);
      return false;
    });
  }

  Future<bool> getPaymentStatus() {
    return SharedPreferences.getInstance()
        .then((instance) => instance.getBool("isPaymentConfigured"))
        .catchError((error) => Logger().e(error));
  }

  Future<bool> setCardData(String cardNumber, String csv, String expire) {
    return SharedPreferences.getInstance()
        .then((instance) => instance
            .setStringList("card", [cardNumber, csv, expire])
            .then((success) => true)
            .catchError((error) => false))
        .catchError((error) {
      Logger().e(error);
    });
  }

  Future<bool> removeCard() {
    return SharedPreferences.getInstance()
        .then((instance) => instance
            .remove('card')
            .then((success) => true)
            .catchError((error) => false))
        .catchError((error) {
      Logger().e(error);
    });
  }

  Future<List<String>> getCardData() {
    return SharedPreferences.getInstance()
        .then((instance) => instance.getStringList("card"))
        .catchError((error) => Logger().e(error));
  }
}
