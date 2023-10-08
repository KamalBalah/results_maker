import 'package:flutter/material.dart';

class DropDownSheetWidget extends StatelessWidget {
  const DropDownSheetWidget({
    super.key,
    required this.selectedSheet,
    required this.sheets,
    required this.onSheetSelected,
  });

  final String? selectedSheet;
  final List<String> sheets;
  final Function(String?) onSheetSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: DropdownButton(
        value: selectedSheet,
        onChanged: onSheetSelected,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        underline: const SizedBox.shrink(),
        borderRadius: BorderRadius.circular(4),
        isExpanded: true,
        items: sheets
            .map(
              (e) => DropdownMenuItem<String>(
                value: e,
                child: Text(e,textAlign: TextAlign.center),
              ),
            )
            .toList(),
      ),
    );
  }
}
