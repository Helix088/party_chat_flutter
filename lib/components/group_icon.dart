import 'package:cloud_firestore/cloud_firestore.dart';

class GroupIcon {
  final String id;
  final String imageUrl;

  GroupIcon({
    required this.id,
    required this.imageUrl,
  });

  factory GroupIcon.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return GroupIcon(
      id: doc.id,
      imageUrl: data['imageUrl'] ?? '',
    );
  }
}
