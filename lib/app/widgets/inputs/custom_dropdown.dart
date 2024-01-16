import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/constants.dart';
import '../cards/expanded_view.dart';
import '../scrollbar.dart';

class DropDown extends StatefulWidget {
  final List<Widget>? dropDownChildren;
  final String? dropDownTitle;

  const DropDown({Key? key, this.dropDownChildren, this.dropDownTitle})
      : super(key: key);

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  bool isStretchedDropDown = false;
  int? groupValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isStretchedDropDown = !isStretchedDropDown;
              });
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.textFormFieldColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        Container(
                          // height: 45,
                          width: double.infinity,
                          padding: const EdgeInsets.only(right: 10),
                          constraints: const BoxConstraints(
                            minHeight: 45,
                            minWidth: double.infinity,
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Text(
                                    widget.dropDownTitle!,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isStretchedDropDown = !isStretchedDropDown;
                                  });
                                },
                                child: Icon(
                                  isStretchedDropDown
                                      ? FontAwesomeIcons.angleUp
                                      : FontAwesomeIcons.angleDown,
                                  size: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                        ExpandedView(
                          expand: isStretchedDropDown,
                          height: 100,
                          child: CustomScrollbar(
                            builder: (context, scrollController2) =>
                                GridView.count(
                              childAspectRatio: 3.5,
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              controller: scrollController2,
                              children: widget.dropDownChildren!,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
