import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../constants/constants.dart';

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    Key? key,
    this.label,
    this.value,
    this.padding,
    this.onChanged,
  }) : super(key: key);

  final bool? value;
  final String? label;
  final EdgeInsets? padding;
  final Function? onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged!(!value!);
      },
      child: Container(
        padding: padding,
        child: Row(
          children: [
            Transform.scale(
              scale: 1.2,
              child: Checkbox(
                side: BorderSide(
                  width: 1,
                  color: AppColor.uncheckedCheckboxColor,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                activeColor: AppColor.primaryColor,
                value: value,
                onChanged: (bool? newValue) {
                  onChanged!(newValue);
                },
              ),
            ),
            label!.text.sm.make(),
          ],
        ),
      ),
    );
  }
}
