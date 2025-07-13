import 'package:coding_interview_frontend/modules/core/data/models/global_models.dart';

abstract class CalculatorRepository {
  Future<List<SelectableItem>> getCrypto();

  Future<List<SelectableItem>> getFiats();

  Future<double> convertCurrency({
    required String criptoCurrencyId,
    required String fiatCurrencyId,
    required double amount,
    required int conversionType,
    required String amountCurrencyId,
  });
}
