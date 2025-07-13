part of 'calculator_bloc.dart';

@immutable
sealed class CalculatorEvent {}

class LoadCurrencies extends CalculatorEvent {}

class SelectFiat extends CalculatorEvent {
  final SelectableItem fiatID;

  SelectFiat(this.fiatID);
}

class SelectCrypto extends CalculatorEvent {
  final SelectableItem cryptoID;

  SelectCrypto(this.cryptoID);
}

class SelectTypeConversion extends CalculatorEvent {
  final int conversionType;

  SelectTypeConversion(this.conversionType);
}

class ConvertCurrency extends CalculatorEvent {
  final double amount;

  ConvertCurrency(this.amount);
}
