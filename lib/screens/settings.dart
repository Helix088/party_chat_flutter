import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/components/btm_nav_bar.dart';

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
      body: Column(
        children: [
          Expanded(
            child: Text('Test'),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(press: (index) {
        if (index == 1) {
          setState(() {
            Navigator.pushNamed(context, SettingsScreen.id);
          });
        } else if (index == 2) {
          setState(() {
            Navigator.pushNamed(context, SettingsScreen.id);
          });
        } else if (index == 3) {
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
