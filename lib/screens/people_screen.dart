// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_flutter/components/btm_nav_bar.dart';
import 'package:flash_chat_flutter/components/bodies.dart';
import 'package:flash_chat_flutter/screens/settings.dart';
import 'package:flutter/material.dart';

import 'chats/list_chats_screen.dart';
import 'email_verification.dart';

User? loggedInUser;
// final _firestore = FirebaseFirestore.instance;

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({Key? key}) : super(key: key);
  static const String id = 'people_screen';

  @override
  _PeopleScreenState createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  final _auth = FirebaseAuth.instance;
  List? users;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: PeopleBody(),
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
        currentIndex: 1,
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.blueGrey,
      title: Text('People'),
      actions: [
        IconButton(
          onPressed: () async {
            await _auth.signOut();
            Navigator.pushReplacementNamed(context, WelcomeScreen.id);
          },
          icon: Icon(Icons.logout),
        ),
      ],
      elevation: 0,
    );
  }
}
