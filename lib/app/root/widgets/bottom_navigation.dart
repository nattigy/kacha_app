import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/constants.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    Key? key,
    required this.currentTab,
    required this.onTap,
  }) : super(key: key);

  final int currentTab;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(1, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: AppColor.primaryColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentTab,
          onTap: (idx) => onTap(idx),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.house),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.briefcase),
              label: 'Jobs',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.circleUser),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
