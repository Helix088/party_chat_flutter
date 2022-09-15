import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'cards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat_flutter/screens/chats/chat_screen.dart';

final _firestore = FirebaseFirestore.instance;

class ChatsDisplay extends StatefulWidget {
  const ChatsDisplay({Key? key}) : super(key: key);
  @override
  State<ChatsDisplay> createState() => _ChatsDisplayState();
}

class _ChatsDisplayState extends State<ChatsDisplay> {
  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('chats')
          .where('users', arrayContainsAny: [currentUser?.email]).snapshots(),
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
                      builder: (context) => ChatScreen(
                            chatId: chatId,
                            users: chatUsers,
                          )));
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

// class PeopleDisplay extends StatefulWidget {
//   const PeopleDisplay({Key? key}) : super(key: key);
//   @override
//   State<PeopleDisplay> createState() => _PeopleDisplayState();
// }

// class _PeopleDisplayState extends State<PeopleDisplay> {
//   final auth = FirebaseAuth.instance.currentUser;

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('Users').snapshots(),
//       builder: (contex, AsyncSnapshot<QuerySnapshot> usersnapshot) {
//         if (usersnapshot.connectionState == ConnectionState.waiting) {
//           return Container(child: Center(child: CircularProgressIndicator()));
//         } else {
//           return Expanded(
//             child: ListView.builder(
//               itemCount: usersnapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 DocumentSnapshot document = usersnapshot.data!.docs[index];
//                 if (document.id == auth!.uid) {
//                   return UsersCard(user: [], press: () {});
//                 } else {
//                   return Text('There are no users');
//                 }
//               },
//             ),
//           );
//         }
//       },
//     );
//   }
// }
