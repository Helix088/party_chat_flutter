import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.press,
    required this.currentIndex,
  }) : super(key: key);

  final Function(int)? press;
  final int? currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex!,
      backgroundColor: Colors.blueGrey,
      onTap: press,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.messenger,
          ),
          label: 'Chats',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.people,
          ),
          label: 'People',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.call),
        //   label: 'Calls',
        //   backgroundColor: Colors.blueGrey,
        // ),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            radius: 14.0,
            backgroundImage: AssetImage('images/pikachu.jpg'),
          ),
          label: 'Profile',
        ),
      ],
      selectedItemColor: Colors.black87,
      unselectedItemColor: Colors.white,
    );
  }
}
