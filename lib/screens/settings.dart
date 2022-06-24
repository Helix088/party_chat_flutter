import 'package:firebase_auth/firebase_auth.dart';
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
  late TextEditingController controller;
  final messageTextController = TextEditingController();
  bool _notifications = false;
  bool _darkMode = false;
  final _auth = FirebaseAuth.instance;
  final _user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    controller = TextEditingController();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        // print(loggedInUser?.email);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String?> changeEmail() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Update Email'),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(hintText: 'Please enter a new email'),
          controller: controller,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final newEmail = await changeEmail();
              if (newEmail == null || newEmail.isEmpty) return;
              _user?.updateEmail(newEmail);
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  Future<String?> changePassword() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Update Password'),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(hintText: 'Please enter a new password'),
          controller: controller,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final newPassword = await changePassword();
              if (newPassword == null || newPassword.isEmpty) return;
              _user?.updatePassword(newPassword);
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

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
                  SwitchListTile(
                    contentPadding: EdgeInsets.all(8.0),
                    title: Text(
                      'Notifications',
                      style: TextStyle(color: Colors.blueGrey[600]),
                    ),
                    value: _notifications,
                    onChanged: (bool value) {
                      setState(() {
                        _notifications = value;
                      });
                    },
                    activeColor: Colors.blueGrey[800],
                    secondary: Icon(
                      Icons.notifications,
                      color: Colors.blueGrey[600],
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        changeEmail();
                      });
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
                      setState(() {
                        changePassword();
                      });
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
                  SwitchListTile(
                    contentPadding: EdgeInsets.all(8.0),
                    title: Text(
                      'Dark Theme',
                      style: TextStyle(color: Colors.blueGrey[600]),
                    ),
                    value: _darkMode,
                    onChanged: (bool value) {
                      setState(() {
                        _darkMode = value;
                      });
                    },
                    activeColor: Colors.blueGrey[800],
                    secondary: Icon(
                      Icons.dark_mode,
                      color: Colors.blueGrey[600],
                    ),
                  ),
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
                      FontAwesomeIcons.circleInfo,
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
                      'Help',
                      style: TextStyle(color: Colors.blueGrey[600]),
                    ),
                    leading: Icon(
                      FontAwesomeIcons.circleQuestion,
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
