import 'dart:io';

import 'package:coding_interview_frontend/modules/core/data/datasources/mock_data.dart';
import 'package:coding_interview_frontend/modules/core/data/models/global_models.dart';
import 'package:coding_interview_frontend/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class CalculatorServices {
  Future<List<SelectableItem>> getFiats() async {
    // This method should return a list of available currencies.
    // For now, we will return an empty list as a placeholder.
    return mockFiat;
  }

  Future<List<SelectableItem>> getCryptos() async {
    // This method should return a list of available currencies.
    // For now, we will return an empty list as a placeholder.
    return mockCripto;
  }

  Future<double> convertCurrency({
    required String criptoCurrencyId,
    required String fiatCurrencyId,
    required double amount,
    required int conversionType,
    required String amountCurrencyId,
  }) async {
    // This method should implement the logic to convert currency.
    // For now, we will return a dummy value as a placeholder.

    final dio = Dio();

    final uri = Uri.parse(Constants.baseUrl).replace(
      queryParameters: {
        'cryptoCurrencyId': criptoCurrencyId,
        'fiatCurrencyId': fiatCurrencyId,
        'amountCurrencyId': amountCurrencyId,
        'type': conversionType.toString(),
        'amount': amount.toString(),
      },
    );
    print('Request URL: $uri');
    final response = await dio.getUri(uri);

    return double.parse(
      response.data['data']['byPrice']["fiatToCryptoExchangeRate"],
    );
  }
}
