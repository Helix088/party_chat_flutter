import 'package:flutter/material.dart';
import 'chat_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat_flutter/screens/chats/chat_screen.dart';

final _firestore = FirebaseFirestore.instance;

class ChatsDisplay extends StatelessWidget {
  const ChatsDisplay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (loggedInUser?.email == null) {
      return Text('users');
    }
    ;
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('chats')
          .where('users', arrayContainsAny: [loggedInUser?.email]).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(backgroundColor: Colors.blueGrey),
          );
        }
        final chats = snapshot.data?.docs.reversed;
        List<ChatsCard> chatsCard = [];
        for (var chat in chats!) {
          final chatId = chat.reference.id;
          final chatTitle = chat.get('title');
          final chatDate = chat.get('lastSent');
          final chatUsers = chat.get('users');

          final chatCard = ChatsCard(
            title: chatTitle,
            lastSent: chatDate,
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ChatScreen(chatId: chatId, users: chatUsers)));
            },
            chat: chatId,
            users: chatUsers,
            //text: '',
          );
          chatsCard.add(chatCard);
          if (chatDate == null) {
            print(Timestamp.now());
          }
        }
        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: chatsCard,
          ),
        );
      },
    );
  }
}




// final chats = snapshot.data?.docs.reversed;
//         List<ChatsCard> chatsCard = [];
//         for (var chat in chats!) {
//           final lastMessage = chat.get('text');

//           final chatCard = ChatsCard(
//             text: lastMessage,
//             press: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => ChatScreen(chatId: chatId)));
//             },
//             chat: chatId,
//             lastSent: Timestamp.now(),
//             title: '',
//           );
//           chatsCard.add(chatCard);
//         }