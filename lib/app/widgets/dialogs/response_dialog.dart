import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../buttons/custom_text_button.dart';

class ResponseDialog extends StatelessWidget {
  const ResponseDialog({
    Key? key,
    this.onDone,
    this.dialogImage,
    this.responseText,
    this.name,
    this.responseInfo,
    this.buttonColor,
  }) : super(key: key);

  final VoidCallback? onDone;
  final String? dialogImage;
  final String? responseText;
  final String? responseInfo;
  final String? name;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.all(30),
      content: SizedBox(
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(dialogImage!),
            const SizedBox(height: 15),
            Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                children: [
                  TextSpan(
                    text: '$responseText\n ',
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            CustomTextButton(
              height: deviceSize.height / 17.3,
              label: 'Done',
              backgroundColor: buttonColor,
              onPressed: onDone,
            ).w32(context)
          ],
        ),
      ),
    );
  }
}
