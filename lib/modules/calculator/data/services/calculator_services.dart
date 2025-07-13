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
    try {
      final dio = Dio();
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
            client.badCertificateCallback =
                (X509Certificate cert, String host, int port) => true;
            return client;
          };
      dio.options.headers['User-Agent'] = 'Mozilla/5.0';
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

      var a = response.data;
      //if ()
      var b = double.parse(a['data']['byPrice']["fiatToCryptoExchangeRate"]);
      return b;
    } catch (e) {
      return 0;
    }
  }
}
