import 'package:flash_chat_flutter/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chats_display.dart';

User? loggedInUser;

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
          color: Colors.blueGrey,
          child: Row(
            children: [
              RoundedButton(
                onPressed: () {},
                title: 'Recent Messages',
                color: Colors.white,
                textColor: Colors.black,
              ),
              SizedBox(
                width: 20.0,
              ),
              RoundedButton(
                onPressed: () {},
                title: 'Active',
                color: Colors.white,
                textColor: Colors.black,
              ),
            ],
          ),
        ),
        ChatsDisplay(),
      ],
    );
  }
}
