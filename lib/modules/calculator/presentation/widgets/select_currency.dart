import 'package:coding_interview_frontend/modules/calculator/presentation/bloc/calculator_bloc.dart';
import 'package:coding_interview_frontend/modules/core/data/models/selectable_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectCurrency extends StatelessWidget {
  final String label;
  final String title;
  final List<SelectableItem> items;
  final SelectableItem selectedItem;

  const SelectCurrency({
    super.key,
    required this.label,
    required this.title,
    required this.items,
    required this.selectedItem,
  });

  void _showItemSelector(BuildContext context) async {
    final bloc = context.read<CalculatorBloc>();
    final result = await showModalBottomSheet<SelectableItem>(
      showDragHandle: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (context) {
        final screenHeight = MediaQuery.of(context).size.height;
        return Container(
          constraints: BoxConstraints(minHeight: screenHeight * 0.6),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: const TextStyle(fontSize: 22)),
              const SizedBox(height: 16),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final item = items[index];
                  final isSelected = item.id == selectedItem.id;

                  return InkWell(
                    onTap: () {
                      Navigator.pop(context, item);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Image.asset(item.image, width: 24, height: 24),
                              const SizedBox(width: 14),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    item.description,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFFF4B53F)
                                  : Colors.black54,
                              width: 2,
                            ),
                            color: isSelected
                                ? const Color(0xFFF4B53F)
                                : Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );

    if (result != null && result.id != selectedItem.id) {
      final currentState = bloc.state;
      if (currentState is CalculatorLoaded) {
        switch (title) {
          case "Cripto":
            bloc.add(SelectCrypto(result));
            break;
          case "FIAT":
            bloc.add(SelectFiat(result));
            break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final badgeOffset = MediaQuery.of(context).size.height * 0.02;

    return GestureDetector(
      onTap: () => _showItemSelector(context),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(selectedItem.image, width: 20, height: 20),
              const SizedBox(width: 8),
              Text(
                selectedItem.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, size: 28),
            ],
          ),
          Positioned(
            top: -badgeOffset,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                label,
                style: const TextStyle(color: Colors.black, fontSize: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
