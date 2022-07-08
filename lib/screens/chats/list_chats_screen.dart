import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_flutter/components/btm_nav_bar.dart';
import 'package:flash_chat_flutter/components/bodies.dart';
import 'package:flutter/material.dart';
import '../people_screen.dart';
import '../settings.dart';
import '../welcome_screen.dart';

User? loggedInUser;
final _firestore = FirebaseFirestore.instance;

class ListChatsScreen extends StatefulWidget {
  const ListChatsScreen({Key? key}) : super(key: key);
  static const String id = 'list_chat_screen';

  @override
  _ListChatsScreenState createState() => _ListChatsScreenState();
}

class _ListChatsScreenState extends State<ListChatsScreen> {
  late TextEditingController controller;
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String? messageText;
  String? title = '';
  List? users;

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
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> newCard({required title, required users}) {
    return _firestore.collection('chats').add({
      'title': title,
      'lastSent': Timestamp.now(),
      'users': [loggedInUser?.email]
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<String?> titleEntry() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Group Chat Name'),
              content: TextField(
                autofocus: true,
                decoration: InputDecoration(hintText: 'Enter Chat Name'),
                controller: controller,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(controller.text);
                  },
                  child: Text('SUBMIT'),
                ),
              ],
            ));
    return Scaffold(
      appBar: buildAppBar(),
      body: ChatBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final title = await titleEntry();
          if (title == null || title.isEmpty) return;
          newCard(title: title, users: users);
        },
        backgroundColor: Colors.blueGrey,
        child: Icon(
          Icons.add_comment,
          color: Colors.white,
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
        currentIndex: 0,
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.blueGrey,
      title: Text('Chats'),
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
