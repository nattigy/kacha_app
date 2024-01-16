import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/input_validators.dart';

class DropDownInput extends StatelessWidget {
  const DropDownInput({
    Key? key,
    required this.onChange,
    required this.itemMap,
    required this.itemController,
    required this.itemText,
    this.readOnly = true,
  }) : super(key: key);

  final Function onChange;
  final List<String> itemMap;
  final TextEditingController itemController;
  final String itemText;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: itemController.text.isEmpty ? null : itemController.text,
      hint: Text(itemText),
      isExpanded: true,
      items: itemMap.map((String item) {
        return DropdownMenuItem(
          value: item.capitalized,
          enabled: readOnly,
          child: Text(item.capitalized),
        );
      }).toList(),
      onChanged: (newValue) => onChange(newValue),
      enableFeedback: true,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.wc_rounded),
        hintStyle: TextStyle(color: Colors.grey),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => FormValidator.validateGender(value as String?),
    );
  }
}
