import 'package:flutter/material.dart';
import 'package:kacha_app/app/app_settings/view/app_settings_page.dart';
import 'package:kacha_app/app/top_up/top_up.dart';
import 'package:kacha_app/utils/navigator.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Colors.orange,
            ),
            child: Center(
              child: Text(
                'Kacha',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          ListTile(
            trailing: Icon(Icons.arrow_upward),
            title: const Text('Top up'),
            onTap: () {
              navigatorPush(context, TopUpPage());
            },
          ),
          ListTile(
            trailing: Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              navigatorPush(context, AppSettings());
            },
          ),
        ],
      ),
    );
  }
}
