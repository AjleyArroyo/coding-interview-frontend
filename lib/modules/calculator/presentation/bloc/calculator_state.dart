part of 'calculator_bloc.dart';

@immutable
sealed class CalculatorState {}

final class CalculatorInitial extends CalculatorState {}

final class CalculatorLoading extends CalculatorState {}

class CalculatorLoaded extends CalculatorState {
  final List<SelectableItem> fiats;
  final List<SelectableItem> cryptos;
  final SelectableItem selectedFiat;
  final SelectableItem selectedCrypto;
  final int selectedTypeConversion;
  final double? convertedAmount;
  final double inputAmount;
  final bool isConverting;
  final bool error;

  CalculatorLoaded({
    required this.fiats,
    required this.cryptos,
    required this.selectedFiat,
    required this.selectedCrypto,
    required this.selectedTypeConversion,
    this.convertedAmount = 0.0,
    required this.inputAmount,
    this.isConverting = false,
    this.error = false,
  });

  CalculatorLoaded copyWith({
    List<SelectableItem>? fiats,
    List<SelectableItem>? cryptos,
    SelectableItem? selectedFiat,
    SelectableItem? selectedCrypto,
    int? selectedTypeConversion,
    double? convertedAmount,
    double? inputAmount,
    bool? isConverting,
    bool? error,
  }) {
    return CalculatorLoaded(
      fiats: fiats ?? this.fiats,
      cryptos: cryptos ?? this.cryptos,
      selectedFiat: selectedFiat ?? this.selectedFiat,
      selectedCrypto: selectedCrypto ?? this.selectedCrypto,
      selectedTypeConversion:
          selectedTypeConversion ?? this.selectedTypeConversion,
      convertedAmount: convertedAmount,
      inputAmount: inputAmount ?? this.inputAmount,
      isConverting: isConverting ?? this.isConverting,
      error: error ?? this.error,
    );
  }
}

class CalculatorError extends CalculatorState {
  final String message;
  CalculatorError(this.message);
}
