import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputField extends StatefulWidget {
  final Function validator;
  final Function onChanged;
  final TextEditingController controller;
  final String hintText;
  final Icon? prefixIcon;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;

  const TextInputField({
    super.key,
    required this.validator,
    required this.onChanged,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.keyboardType,
    this.readOnly,
    this.inputFormatters,
    this.maxLines,
  });

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => widget.validator(value),
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (v) => widget.onChanged(v),
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
      ),
      readOnly: widget.readOnly ?? false,
      inputFormatters: widget.inputFormatters,
      maxLines: widget.maxLines,
    );
  }
}
