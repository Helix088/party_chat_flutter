import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flash_chat_flutter/screens/login_screen.dart';
import 'package:flutter/material.dart';

class ProtectedRoute extends StatefulWidget {
  const ProtectedRoute({Key? key, required this.screen}) : super(key: key);

  @override
  State<ProtectedRoute> createState() => _ProtectedRouteState();
  static const String id = 'protected_route';
  final Widget screen;
}

class _ProtectedRouteState extends State<ProtectedRoute> {
  Future<void> loadingWidget = EasyLoading.show(status: 'loading...');
  bool _isLoading = true;
  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        // Push to login;
        Navigator.pushNamedAndRemoveUntil(
            context, LoginScreen.id, (route) => false);
      }
      setState(() {
        _isLoading = false;
      });
    });
    return Container(
      child: _isLoading
          ? Container(
              child: loadingWidget,
            )
          : widget.screen,
    );
  }
}
