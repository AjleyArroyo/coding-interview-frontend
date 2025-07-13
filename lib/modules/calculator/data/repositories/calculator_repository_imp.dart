import 'package:coding_interview_frontend/modules/calculator/data/services/calculator_services.dart';
import 'package:coding_interview_frontend/modules/calculator/domain/repositories/calculator_repositories.dart';
import 'package:coding_interview_frontend/modules/core/data/models/global_models.dart';

class CalculatorRepositoryImpl implements CalculatorRepository {
  final CalculatorServices _calculatorServices = CalculatorServices();

  @override
  Future<List<SelectableItem>> getCrypto() async {
    final cryptoList = await _calculatorServices.getCryptos();
    return cryptoList;
  }

  @override
  Future<List<SelectableItem>> getFiats() async {
    final fiatList = await _calculatorServices.getFiats();
    return fiatList;
  }

  @override
  Future<double> convertCurrency({
    required String criptoCurrencyId,
    required String fiatCurrencyId,
    required double amount,
    required int conversionType,
    required String amountCurrencyId,
  }) async {
    return await _calculatorServices.convertCurrency(
      fiatCurrencyId: fiatCurrencyId,
      criptoCurrencyId: criptoCurrencyId,
      amount: amount,
      conversionType: conversionType,
      amountCurrencyId: amountCurrencyId,
    );
  }
}
