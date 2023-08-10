import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'group_icon.dart';

class GroupIconsProvider extends ChangeNotifier {
  List<GroupIcon> _groupIcons = [];

  List<GroupIcon> get groupIcons => _groupIcons;

  Future<void> fetchGroupIcons() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('group_icons').get();
      _groupIcons =
          snapshot.docs.map((doc) => GroupIcon.fromFirestore(doc)).toList();
      notifyListeners();
    } catch (e) {
      print('Error fetching group icons: $e');
    }
  }

  Future<void> updateGroupIconForChat(String chatId, String imageUrl) async {
    try {
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .update({'groupIcon': imageUrl});
    } catch (e) {
      print('Error updating group icon for chat: $e');
    }
  }
}
