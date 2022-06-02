import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.press,
  }) : super(key: key);

  final Function(int)? press;
  final int? _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex!,
      onTap: press,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.messenger),
          label: 'Chats',
          backgroundColor: Colors.blueGrey,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'People',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.call),
          label: 'Calls',
        ),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            radius: 14.0,
            backgroundImage: AssetImage('images/pikachu.jpg'),
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
