import 'package:flash_chat_flutter/screens/take_picture.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flash_chat_flutter/components/message_stream.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

final _firestore = FirebaseFirestore.instance;
User? loggedInUser;

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
    required this.chatId,
    required this.users,
  }) : super(key: key);
  static const String id = 'chat_screen';
  final String chatId;
  final List users;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController controller;
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final title = _firestore.collection('chats').doc('title');
  String? messageText;
  PickedFile? _imageFile;
  ImagePicker _picker = ImagePicker();

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

  Future<void> addUser({required users}) {
    final db = _firestore.collection('chats').doc(widget.chatId);
    return db.update({
      'users': FieldValue.arrayUnion([users])
    });
  }

  Future<String?> addNewUsers() => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Add Users to Chat'),
            content: TextField(
              autofocus: true,
              decoration: InputDecoration(hintText: 'Enter User Email'),
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

  Widget groupImage() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 40.0,
            // ignore: unnecessary_null_comparison
            backgroundImage: _imageFile == null
                ? AssetImage("assets/images/pikachu.jpg")
                : FileImage(File(_imageFile!.path)) as ImageProvider<Object>,
          ),
          Positioned(
              bottom: 10.0,
              right: 10.0,
              child: InkWell(
                onTap: (() {
                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) => bottomSheet()),
                  );
                }),
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 28.0,
                ),
              ))
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(children: [
        Text(
          "Choose Profile Photo",
          style: TextStyle(fontSize: 20.0),
        ),
        SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            TextButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                icon: Icon(Icons.image),
                label: Text("Gallery")),
          ],
        )
      ]),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _imageFile = pickedFile as PickedFile?;
    });
  }

  Future<String?> changeSettings() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Group Settings'),
        actions: <Widget>[
          Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  children: [
                    groupImage(),
                    ListTile(
                      onTap: () {
                        setState(() async {
                          final newUser = await addNewUsers();
                          if (newUser == null || newUser.isEmpty) return;
                          addUser(users: newUser);
                        });
                      },
                      title: Text(
                        'Add User',
                      ),
                      trailing: Icon(
                        Icons.person_add_alt,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              changeSettings();
            },
          ),
        ],
        title: Text(''),
        backgroundColor: Colors.blueGrey,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(chatId: widget.chatId),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, TakePictureScreen.id);
                    },
                    child: Icon(
                      FontAwesomeIcons.camera,
                      color: Colors.blueGrey,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration.copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              FontAwesomeIcons.circleArrowUp,
                              color: Colors.blueGrey,
                            ),
                            onPressed: () {
                              messageTextController.clear();
                              _firestore.collection('messages').add({
                                'chatId': widget.chatId,
                                'text': messageText,
                                'sender': loggedInUser?.email,
                                'sent': Timestamp.now(),
                              });
                            },
                          ),
                          fillColor: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Icon(
                      FontAwesomeIcons.circlePlus,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
