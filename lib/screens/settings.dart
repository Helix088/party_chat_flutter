import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_flutter/screens/chats/list_chats_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/components/btm_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flash_chat_flutter/components/theme_provider.dart';

import 'people_screen.dart';

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
  final _auth = FirebaseAuth.instance;
  final _user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  Future<String?> changeEmail() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Update Email'),
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
        title: Text('Reset Password?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _auth.sendPasswordResetEmail(email: (_user!.email).toString());
              Navigator.pop(context, 'Submit');
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  Future<String?> changeLanguage() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Select Language'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _auth.sendPasswordResetEmail(email: (_user!.email).toString());
              Navigator.pop(context, 'Submit');
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
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
                  // ListTile(
                  //   onTap: () async {
                  //     await ImagePicker.pickImage(source: ImageSource.gallery);
                  //   },
                  //   title: Text(
                  //     'Photo',
                  //   ),
                  //   leading: CircleAvatar(
                  //     foregroundImage: ,
                  //   ),
                  //   trailing: Icon(
                  //     Icons.edit,
                  //   ),
                  // ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.all(8.0),
                    title: Text(
                      'Notifications',
                    ),
                    value: _notifications,
                    onChanged: (bool value) {
                      setState(() {
                        _notifications = value;
                      });
                    },
                    activeColor: Colors.blueGrey[600],
                    secondary: Icon(
                      Icons.notifications,
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
                    ),
                    leading: Icon(
                      Icons.email,
                    ),
                    trailing: Icon(
                      Icons.edit,
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
                    ),
                    leading: Icon(
                      Icons.lock_person_rounded,
                    ),
                    trailing: Icon(
                      Icons.edit,
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
                    ),
                    value: themeProvider.isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        final provider = themeProvider;
                        provider.toggleTheme(value);
                      });
                    },
                    activeColor: Colors.blueGrey[600],
                    secondary: Icon(
                      Icons.dark_mode,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {});
                    },
                    title: Text(
                      'Language',
                    ),
                    leading: Icon(
                      FontAwesomeIcons.language,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {});
                    },
                    title: Text(
                      'Location',
                    ),
                    leading: Icon(
                      Icons.location_on,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
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
                    ),
                    leading: Icon(
                      FontAwesomeIcons.circleInfo,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {});
                    },
                    title: Text(
                      'Help',
                    ),
                    leading: Icon(
                      FontAwesomeIcons.circleQuestion,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        press: (index) {
          if (index == 0) {
            setState(() {
              Navigator.pushNamed(context, ListChatsScreen.id);
            });
          } else if (index == 1) {
            setState(() {
              Navigator.pushNamed(context, PeopleScreen.id);
            });
          } else if (index == 2) {
            setState(() {
              Navigator.pushNamed(context, SettingsScreen.id);
            });
          }
          // } else if (index == 2) {
          //   setState(() {
          //     Navigator.pushNamed(context, SettingsScreen.id);
          //   });
        },
        currentIndex: 2,
      ),
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
