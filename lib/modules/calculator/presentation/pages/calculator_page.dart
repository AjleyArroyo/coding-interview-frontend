import 'package:coding_interview_frontend/modules/calculator/presentation/bloc/calculator_bloc.dart';
import 'package:coding_interview_frontend/modules/calculator/presentation/widgets/calculator_widgets.dart';
import 'package:coding_interview_frontend/modules/core/widgets/custom_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: BlocBuilder<CalculatorBloc, CalculatorState>(
          builder: (context, state) {
            if (state is CalculatorLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is CalculatorError) {
              return Center(
                child: Text(
                  'Error Cargando Currency',
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
              );
            }
            if (state is CalculatorLoaded) {
              return Center(
                child: Card(
                  color: Colors.white,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.80,
                    padding: const EdgeInsets.symmetric(
                      vertical: 32,
                      horizontal: 24,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ExchangeWidget(
                          state.fiats,
                          state.cryptos,
                          state.selectedTypeConversion,
                        ),
                        SizedBox(height: 16),
                        InputAmountWidget(
                          state.selectedTypeConversion == 1
                              ? state.selectedCrypto.name
                              : state.selectedFiat.name,
                        ),
                        SizedBox(height: 30),
                        ConvertDetailWidget(),
                        SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Implement the exchange action here
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF4B53F),
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 24,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              "Cambiar",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
