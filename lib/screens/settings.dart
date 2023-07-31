import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_flutter/screens/chats/list_chats_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/components/btm_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
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
  bool _location = false;
  final _auth = FirebaseAuth.instance;
  final _user = FirebaseAuth.instance.currentUser;
  File? _imageFile;
  ImagePicker _picker = ImagePicker();
  String selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  Widget imageProfile(File? imageFile) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 65.0,
            backgroundImage: imageFile == null
                ? AssetImage("assets/images/pikachu.jpg")
                : FileImage(imageFile) as ImageProvider<Object>,
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: InkWell(
              onTap: () {
                _pickImage();
              },
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 28.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _imageFile = pickedFile as File?;
    });
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

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("English"), value: "English"),
      DropdownMenuItem(child: Text("Spanish"), value: "Spanish"),
      DropdownMenuItem(child: Text("French"), value: "French"),
      DropdownMenuItem(child: Text("German"), value: "German"),
    ];
    return menuItems;
  }

  Future<String?> changeLanguage() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Select Language'),
        actions: <Widget>[
          DropdownButtonFormField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              filled: true,
              fillColor: Colors.blueGrey,
            ),
            onChanged: (String? newLang) {
              setState(() {
                selectedLanguage = newLang!;
              });
            },
            value: selectedLanguage,
            items: dropdownItems,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
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
                    imageProfile(_imageFile),
                    SwitchListTile(
                      contentPadding: EdgeInsets.only(right: 8.0, left: 16.0),
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
                      contentPadding: EdgeInsets.only(right: 8.0, left: 16.0),
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
                        setState(() {
                          changeLanguage();
                        });
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
                    SwitchListTile(
                      contentPadding: EdgeInsets.only(right: 8.0, left: 17.0),
                      title: Text(
                        'Location',
                      ),
                      value: _location,
                      onChanged: (bool value) {
                        setState(() {
                          _location = value;
                        });
                      },
                      activeColor: Colors.blueGrey[600],
                      secondary: Icon(
                        Icons.location_on,
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
    });
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
