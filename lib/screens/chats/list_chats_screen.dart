import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_flutter/components/btm_nav_bar.dart';
import 'package:flash_chat_flutter/components/chats_body.dart';
import 'package:flash_chat_flutter/components/chats_display.dart';
import 'package:flutter/material.dart';
import '../settings.dart';

User? loggedInUser;

class ListChatsScreen extends StatefulWidget {
  const ListChatsScreen({Key? key}) : super(key: key);
  static const String id = 'list_chat_screen';

  @override
  _ListChatsScreenState createState() => _ListChatsScreenState();
}

class _ListChatsScreenState extends State<ListChatsScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String? messageText;

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
        print(loggedInUser?.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            ChatsDisplay.updateData;
          });
        },
        backgroundColor: Colors.blueGrey,
        child: Icon(
          Icons.add_comment,
          color: Colors.white,
        ),
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

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.blueGrey,
      title: Text('Chats'),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.search),
        ),
      ],
      elevation: 0,
    );
  }
}
