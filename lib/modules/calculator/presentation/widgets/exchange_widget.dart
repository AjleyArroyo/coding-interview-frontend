import 'package:coding_interview_frontend/modules/calculator/presentation/bloc/calculator_bloc.dart';
import 'package:coding_interview_frontend/modules/core/data/models/global_models.dart';
import 'package:coding_interview_frontend/modules/calculator/presentation/widgets/calculator_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

class ExchangeWidget extends StatelessWidget {
  final List<SelectableItem> fiats;
  final List<SelectableItem> cryptos;
  final int conversionType;
  const ExchangeWidget(
    this.fiats,
    this.cryptos,
    this.conversionType, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = kIsWeb
        ? MediaQuery.of(context).size.width * 0.5
        : MediaQuery.of(context).size.width;
    final swapSpace = screenWidth * 0.16; // espacio para el botón central
    final state = context.watch<CalculatorBloc>().state as CalculatorLoaded;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: const Color(0xFFF4B53F), width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectCurrency(
                label: "TENGO",
                title: conversionType == 1 ? "Cripto" : "FIAT",
                items: conversionType == 1 ? cryptos : fiats,
                selectedItem: conversionType == 1
                    ? state.selectedCrypto
                    : state.selectedFiat,
              ),

              SizedBox(width: swapSpace),
              SelectCurrency(
                label: "QUIERO",
                title: conversionType == 1 ? "FIAT" : "Cripto",
                items: conversionType == 1 ? fiats : cryptos,
                selectedItem: conversionType == 1
                    ? state.selectedFiat
                    : state.selectedCrypto,
              ),
            ],
          ),
        ),

        const Positioned(top: null, bottom: null, child: _SwapButton()),
      ],
    );
  }
}

// Botón de intercambio central
class _SwapButton extends StatefulWidget {
  const _SwapButton();

  @override
  State<_SwapButton> createState() => _SwapButtonState();
}

class _SwapButtonState extends State<_SwapButton> {
  double _turns = 0;

  void _toggleRotation() {
    setState(() {
      _turns += 0.5; // 180 grados = 0.5 vueltas
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = kIsWeb
        ? MediaQuery.of(context).size.width * 0.5
        : MediaQuery.of(context).size.width;
    final buttonSize = screenWidth * 0.2 * 0.6;

    return InkWell(
      onTap: () {
        _toggleRotation();
        final bloc = context.read<CalculatorBloc>();
        final currentState = bloc.state;
        if (currentState is CalculatorLoaded) {
          final newType = currentState.selectedTypeConversion == 0 ? 1 : 0;
          bloc.add(SelectTypeConversion(newType));
        }
      },
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFF4B53F),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: AnimatedRotation(
            turns: _turns,
            duration: Duration(milliseconds: 300),
            child: Icon(Icons.swap_horiz, color: Colors.white, size: 30),
          ),
        ),
      ),
    );
  }
}
