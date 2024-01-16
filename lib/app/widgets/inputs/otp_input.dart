import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../../constants/app_colors.dart';

class OtpInput extends StatelessWidget {
  const OtpInput({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onCompleted,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function(String pin) onCompleted;

  @override
  Widget build(BuildContext context) {
    final focusedBorderColor = AppColor.primaryColor;
    final fillColor = AppColor.textFormFieldColor;
    const borderColor = Colors.transparent;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
        color: fillColor,
      ),
    );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        length: 6,
        controller: controller,
        focusNode: focusNode,
        androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
        listenForMultipleSmsOnAndroid: true,
        defaultPinTheme: defaultPinTheme,
        separatorBuilder: (index) => const SizedBox(width: 8),
        validator: (value) => value?.length == 6 ? null : 'Pin is incorrect',
        onClipboardFound: (value) {
          debugPrint('onClipboardFound: $value');
        },
        hapticFeedbackType: HapticFeedbackType.lightImpact,
        onCompleted: onCompleted,
        onChanged: (value) {
          debugPrint('onChanged: $value');
        },
        onSubmitted: (pin) {
          debugPrint('onSubmitted: $pin');
        },
        cursor: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 9),
              width: 22,
              height: 1,
              color: focusedBorderColor,
            ),
          ],
        ),
        focusedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: focusedBorderColor),
          ),
        ),
        submittedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: focusedBorderColor),
          ),
        ),
        errorPinTheme: defaultPinTheme.copyBorderWith(
          border: Border.all(color: Colors.redAccent),
        ),
      ),
    );
  }
}
