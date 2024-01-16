import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../buttons/custom_text_button.dart';

class RequestDialog extends StatefulWidget {
  const RequestDialog({
    Key? key,
    this.onRequest,
    this.dialogImage,
    this.text,
    this.name,
    this.requestLabel,
    this.reasonsLabel,
    this.reasons,
    this.color,
  }) : super(key: key);

  final VoidCallback? onRequest;
  final String? dialogImage;
  final String? text;
  final String? name;
  final String? requestLabel;
  final String? reasonsLabel;
  final Color? color;
  final List<String>? reasons;

  @override
  State<RequestDialog> createState() => _RequestDialogState();
}

class _RequestDialogState extends State<RequestDialog> {
  String? dropdownValue;

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
            Image.asset(widget.dialogImage!),
            const SizedBox(height: 15),
            Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                children: [
                  TextSpan(
                    text: widget.text,
                    style: TextStyle(color: AppColor.greyTextColor),
                  ),
                  TextSpan(
                    text: widget.name,
                    style: TextStyle(
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            CustomTextButton(
              height: deviceSize.height / 17.3,
              label: widget.requestLabel,
              backgroundColor: widget.color ?? AppColor.declineColor,
              onPressed: widget.onRequest,
            )
          ],
        ),
      ),
    );
  }
}
