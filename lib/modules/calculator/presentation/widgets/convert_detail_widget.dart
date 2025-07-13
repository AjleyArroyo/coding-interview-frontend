import 'package:coding_interview_frontend/modules/calculator/presentation/bloc/calculator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redacted/redacted.dart';

class ConvertDetailWidget extends StatelessWidget {
  const ConvertDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CalculatorBloc>().state as CalculatorLoaded;

    final result = state.selectedTypeConversion == 1
        ? (state.convertedAmount ?? 0) * state.inputAmount
        : (state.convertedAmount ?? 0) == 0
        ? 0
        : state.inputAmount / (state.convertedAmount ?? 1);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Tasa estimada"),
            Row(
              children: [
                Text(
                  "= ${(state.convertedAmount ?? 0.0).toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 16),
                ).redacted(context: context, redact: state.isConverting),
                SizedBox(width: 6),

                Text(
                  state.selectedTypeConversion == 0
                      ? state.selectedCrypto.name
                      : state.selectedFiat.name,
                  style: TextStyle(fontSize: 11),
                ).redacted(context: context, redact: state.isConverting),
              ],
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Recibirás"),
            Row(
              children: [
                Text(
                  "= ${result.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 16),
                ).redacted(context: context, redact: state.isConverting),
                SizedBox(width: 6),
                Text(
                  state.selectedTypeConversion == 0
                      ? state.selectedCrypto.name
                      : state.selectedFiat.name,
                  style: TextStyle(fontSize: 11),
                ).redacted(context: context, redact: state.isConverting),
              ],
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Tiempo estimado"),
            Row(
              children: [
                Text(
                  "= 10",
                  style: TextStyle(fontSize: 16),
                ).redacted(context: context, redact: state.isConverting),
                SizedBox(width: 6),
                Text(
                  "Min",
                  style: TextStyle(fontSize: 11),
                ).redacted(context: context, redact: state.isConverting),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
