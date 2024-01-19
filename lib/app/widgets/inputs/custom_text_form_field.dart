import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/constants.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    Key? key,
    this.filled,
    this.fillColor,
    this.textEditingController,
    this.obscureText = false,
    this.textInputAction,
    this.keyboardType = TextInputType.text,
    this.labelText,
    this.hintText,
    this.errorText,
    required this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.focusNode,
    this.nextFocusNode,
    this.isReadOnly = false,
    this.onTap,
    this.minLines,
    this.maxLines,
    this.suffixIcon,
    this.prefixIcon,
    this.underline = false,
    this.inputFormatters,
    this.initialValue = "",
  }) : super(key: key);

  //
  final bool? filled;
  final Color? fillColor;
  final TextEditingController? textEditingController;
  final bool? obscureText;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  //
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final String? initialValue;

  final Function(String)? onChanged;
  final Function? onFieldSubmitted;

  final String? Function(String?) validator;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;

  final bool? isReadOnly;
  final VoidCallback? onTap;
  final int? minLines;
  final int? maxLines;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final bool? underline;
  final List<TextInputFormatter>? inputFormatters;

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: widget.fillColor ?? AppColor.textFormFieldColor,
        labelText: widget.labelText,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Colors.grey.withOpacity(0.8),
          fontSize: 14,
        ),
        labelStyle: TextStyle(
          color: Colors.grey.withOpacity(0.8),
          fontSize: 14,
        ),
        errorText: widget.errorText,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.primaryColor),
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon ?? _getSuffixWidget(),
        contentPadding: const EdgeInsets.all(10),
      ),
      inputFormatters: widget.inputFormatters,
      cursorColor: AppColor.cursorColor,
      obscureText: (widget.obscureText!) ? !makePasswordVisible : false,
      onTap: widget.onTap,
      readOnly: widget.isReadOnly!,
      controller: widget.textEditingController ?? widget.textEditingController
        ?..selection = TextSelection(
            baseOffset: widget.textEditingController!.text.length,
            extentOffset: widget.textEditingController!.text.length),
      validator: (value) => widget.validator(value),
      focusNode: widget.focusNode,
      onFieldSubmitted: (data) {
        if (widget.onFieldSubmitted != null) {
          widget.onFieldSubmitted!(data);
        } else {
          FocusScope.of(context).requestFocus(widget.nextFocusNode);
        }
      },
      autofocus: false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      minLines: widget.minLines,
      maxLines: widget.obscureText! ? 1 : widget.maxLines,
    );
  }

  //check if it's password input
  bool makePasswordVisible = false;

  Widget _getSuffixWidget() {
    if (widget.obscureText!) {
      return ButtonTheme(
        minWidth: 30,
        height: 30,
        padding: const EdgeInsets.all(0),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(0),
          ),
          onPressed: () {
            setState(() {
              makePasswordVisible = !makePasswordVisible;
            });
          },
          child: Icon(
            (!makePasswordVisible)
                ? FontAwesomeIcons.eye
                : FontAwesomeIcons.eyeSlash,
            color: Colors.grey,
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
