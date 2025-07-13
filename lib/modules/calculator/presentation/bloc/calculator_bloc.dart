import 'package:coding_interview_frontend/modules/calculator/domain/repositories/calculator_repository.dart';
import 'package:coding_interview_frontend/modules/core/data/models/global_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  final CalculatorRepository calculatorRepository;
  CalculatorBloc(this.calculatorRepository) : super(CalculatorInitial()) {
    on<LoadCurrencies>((event, emit) async {
      emit(CalculatorLoading());
      try {
        final List<SelectableItem> fiats = await calculatorRepository
            .getFiats();
        final List<SelectableItem> cryptos = await calculatorRepository
            .getCrypto();
        emit(
          CalculatorLoaded(
            fiats: fiats,
            cryptos: cryptos,
            selectedFiat: fiats.first,
            selectedCrypto: cryptos.first,
            selectedTypeConversion: 1,
            inputAmount: 0.00,
            convertedAmount: 0.00,
            error: false,
          ),
        );
      } catch (e) {
        emit(CalculatorError(e.toString()));
      }
    });
    on<SelectFiat>((event, emit) async {
      if (state is CalculatorLoaded) {
        final current = state as CalculatorLoaded;
        emit(current.copyWith(selectedFiat: event.fiatID));
        if (current.inputAmount > 0) {
          add(ConvertCurrency(current.inputAmount));
        }
      }
    });
    on<SelectCrypto>((event, emit) async {
      if (state is CalculatorLoaded) {
        final current = state as CalculatorLoaded;
        emit(current.copyWith(selectedCrypto: event.cryptoID));
        if (current.inputAmount > 0) {
          add(ConvertCurrency(current.inputAmount));
        }
      }
    });
    on<SelectTypeConversion>((event, emit) {
      if (state is CalculatorLoaded) {
        final current = state as CalculatorLoaded;
        emit(current.copyWith(selectedTypeConversion: event.conversionType));
        if (current.inputAmount > 0) {
          add(ConvertCurrency(current.inputAmount));
        }
      }
    });

    int requestVersion = 0;

    on<ConvertCurrency>((event, emit) async {
      final currentVersion = ++requestVersion;
      if (state is CalculatorLoaded) {
        final current = state as CalculatorLoaded;
        emit(current.copyWith(isConverting: true, inputAmount: event.amount));
        try {
          final convertedAmount = await calculatorRepository.convertCurrency(
            fiatCurrencyId: current.selectedFiat.id,
            criptoCurrencyId: current.selectedCrypto.id,
            amount: event.amount,
            conversionType: current.selectedTypeConversion,
            amountCurrencyId: current.selectedTypeConversion == 1
                ? current.selectedCrypto.id
                : current.selectedFiat.id,
          );
          //Ignora si hay otra llamada a la api distinta a la actual
          if (currentVersion != requestVersion) return;
          emit(
            current.copyWith(
              convertedAmount: convertedAmount,
              inputAmount: event.amount,
              isConverting: false,
              error: false,
            ),
          );
        } catch (e) {
          emit((state as CalculatorLoaded).copyWith(error: true));
        }
      }
    });
  }
}
