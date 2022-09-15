// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_flutter/components/btm_nav_bar.dart';
import 'package:flash_chat_flutter/constants.dart';
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
  List<Contact> contacts = [];
  List<Contact> contactsFiltered = [];
  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getAllContacts();
    searchController.addListener(() {
      filterContacts();
    });
  }

  getAllContacts() async {
    List<Contact> _contacts = (await ContactsService.getContacts()).toList();
    setState(() {
      contacts = _contacts;
    });
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

  filterContacts() {
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();
        String contactName = contact.displayName!.toLowerCase();
        return contactName.contains(searchTerm);
      });

      setState(() {
        contactsFiltered = _contacts;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                    labelText: 'Search',
                    fillColor: Colors.blueGrey,
                    border: OutlineInputBorder(
                      borderSide: new BorderSide(
                        color: Colors.blueGrey,
                        width: 5.0,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.blueGrey,
                    )),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: isSearching == true
                    ? contactsFiltered.length
                    : contacts.length,
                itemBuilder: (context, index) {
                  Contact contact = isSearching == true
                      ? contactsFiltered[index]
                      : contacts[index];
                  return ListTile(
                    title: Text(contact.displayName!),
                    subtitle: Text(contact.phones!.elementAt(0).value!),
                    leading:
                        (contact.avatar != null && contact.avatar!.length > 0)
                            ? CircleAvatar(
                                backgroundImage: MemoryImage(contact.avatar!),
                              )
                            : CircleAvatar(
                                child: Text(contact.initials()),
                              ),
                  );
                },
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
