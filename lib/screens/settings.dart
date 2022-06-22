import 'package:flash_chat_flutter/screens/chats/list_chats_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/components/btm_nav_bar.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  static const String id = 'settings_screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('Common'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.language),
                title: Text('Language'),
                value: Text('English'),
              ),
              SettingsTile.switchTile(
                onToggle: (value) {},
                initialValue: true,
                leading: Icon(Icons.dark_mode),
                title: Text('Dark Theme'),
              ),
              SettingsTile.switchTile(
                onToggle: (value) {},
                initialValue: true,
                leading: Icon(Icons.format_paint),
                title: Text('Enable custom theme'),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(press: (index) {
        if (index == 0) {
          setState(() {
            Navigator.pushNamed(context, ListChatsScreen.id);
          });
        } else if (index == 1) {
          setState(() {
            Navigator.pushNamed(context, SettingsScreen.id);
          });
        } else if (index == 2) {
          setState(() {
            Navigator.pushNamed(context, SettingsScreen.id);
          });
        } else {
          setState(() {
            Navigator.pushNamed(context, SettingsScreen.id);
          });
        }
      }),
    );
  }
}

AppBar buildAppBar() {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.blueGrey,
    title: Text('Settings'),
    actions: [
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.search),
      ),
    ],
    elevation: 0,
  );
}
