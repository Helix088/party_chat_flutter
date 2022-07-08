import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'displays.dart';

User? loggedInUser;

class ChatBody extends StatelessWidget {
  const ChatBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
          color: Colors.blueGrey,
          child: Row(),
        ),
        ChatsDisplay(),
      ],
    );
  }
}

class PeopleBody extends StatelessWidget {
  const PeopleBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
          color: Colors.blueGrey,
          child: Row(),
        ),
        PeopleDisplay(),
      ],
    );
  }
}
