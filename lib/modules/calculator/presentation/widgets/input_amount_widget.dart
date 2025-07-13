import 'package:coding_interview_frontend/modules/calculator/presentation/bloc/calculator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputAmountWidget extends StatefulWidget {
  final String label;
  const InputAmountWidget(this.label, {super.key});

  @override
  InputAmountWidgetState createState() => InputAmountWidgetState();
}

class InputAmountWidgetState extends State<InputAmountWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFF4B53F), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          Text(
            widget.label,
            style: const TextStyle(
              color: Color(0xFFF4B53F),
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              onEditingComplete: () {
                final parsed = double.parse(
                  _controller.text.replaceAll(",", "."),
                );
                context.read<CalculatorBloc>().add(ConvertCurrency(parsed));
              },
              onChanged: (value) {
                _controller.text = value.replaceAll(",", ".");

                final parsed = double.tryParse(_controller.text) ?? 0;
                context.read<CalculatorBloc>().add(ConvertCurrency(parsed));
              },
              controller: _controller,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "0.00",
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
