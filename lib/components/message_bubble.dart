import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {Key? key,
      required this.sender,
      required this.text,
      required this.isMe,
      required this.sent})
      : super(key: key);

  final String sender;
  final String text;
  final bool isMe;
  final Timestamp sent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0))
                : BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0)),
            elevation: 5.0,
            color: isMe ? Colors.blueGrey : Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                '$text',
                style: isMe
                    ? TextStyle(color: Colors.white, fontSize: 15.0)
                    : TextStyle(color: Colors.black, fontSize: 15.0),
              ),
            ),
          ),
          Text(
            sender,
            style: TextStyle(fontSize: 12.0, color: Colors.black54),
          ),
          Text(
            DateFormat.yMd().add_jm().format(sent.toDate()),
            style: TextStyle(fontSize: 12.0, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
