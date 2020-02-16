import 'package:fpay_driver/config/config.dart';
import 'package:fpay_driver/model/card.dart';
import 'package:fpay_driver/services/pref_service.dart';
import 'package:logger/logger.dart';

class PaymentService {
  final baseUrl = Config.baseUrl;

  Future<bool> isPaymentConfigured() {
    return PrefService()
        .getPaymentStatus()
        .then((state) => (state != null) ? state : false);
  }

  Future<bool> saveCard(CardData card) {
    return PrefService()
        .setCardData(card.cardNumber, card.csv, card.expire)
        .then((_) async {
      Logger().i(_);
      if (_) {
        Logger().i(_);
        return await PrefService().setPaymentStatus(true);
      }
      return false;
    });
  }

  Future<bool> removeCard() {
    return PrefService().removeCard().then((_) async {
      if (_) return await PrefService().setPaymentStatus(false);
      return false;
    });
  }

  Future<CardData> fetchCard() {
    return PrefService().getCardData().then((list) {
      return CardData(cardNumber: list[0], csv: list[1], expire: list[2]);
    });
  }
}
