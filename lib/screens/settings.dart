import 'package:flash_chat_flutter/screens/chats/list_chats_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/components/btm_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      setState(() {});
                    },
                    title: Text(
                      'Email',
                      style: TextStyle(color: Colors.blueGrey[600]),
                    ),
                    leading: Icon(
                      Icons.email,
                      color: Colors.blueGrey[600],
                    ),
                    trailing: Icon(
                      Icons.edit,
                      color: Colors.blueGrey[600],
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {});
                    },
                    title: Text(
                      'Change Password',
                      style: TextStyle(color: Colors.blueGrey[600]),
                    ),
                    leading: Icon(
                      Icons.lock_person_rounded,
                      color: Colors.blueGrey[600],
                    ),
                    trailing: Icon(
                      Icons.edit,
                      color: Colors.blueGrey[600],
                    ),
                  ),
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      setState(() {});
                    },
                    title: Text(
                      'Language',
                      style: TextStyle(color: Colors.blueGrey[600]),
                    ),
                    leading: Icon(
                      FontAwesomeIcons.language,
                      color: Colors.blueGrey[600],
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.blueGrey[600],
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {});
                    },
                    title: Text(
                      'Location',
                      style: TextStyle(color: Colors.blueGrey[600]),
                    ),
                    leading: Icon(
                      Icons.location_on,
                      color: Colors.blueGrey[600],
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.blueGrey[600],
                    ),
                  ),
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      setState(() {});
                    },
                    title: Text(
                      'About Us',
                      style: TextStyle(color: Colors.blueGrey[600]),
                    ),
                    leading: Icon(
                      Icons.abc,
                      color: Colors.blueGrey[600],
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.blueGrey[600],
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {});
                    },
                    title: Text(
                      'Location',
                      style: TextStyle(color: Colors.blueGrey[600]),
                    ),
                    leading: Icon(
                      Icons.location_on,
                      color: Colors.blueGrey[600],
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.blueGrey[600],
                    ),
                  ),
                ],
              ),
            ),
            SwitchListTile(
              contentPadding: const EdgeInsets.all(8.0),
              title: Text('Change Theme'),
              value: true,
              onChanged: (value) {},
              activeColor: Colors.blueGrey[800],
            ),
          ],
        ),
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
    title: Align(
      alignment: Alignment.center,
      child: Text(
        'Settings',
      ),
    ),
    elevation: 0,
  );
}
