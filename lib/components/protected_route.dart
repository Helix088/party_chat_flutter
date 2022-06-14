import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_flutter/screens/login_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/material.dart';

class ProtectedRoute extends StatefulWidget {
  const ProtectedRoute({Key? key, required this.screen}) : super(key: key);

  @override
  State<ProtectedRoute> createState() => _ProtectedRouteState();
  static const String id = 'protected_route';
  final Widget screen;
}

class _ProtectedRouteState extends State<ProtectedRoute> {
  bool _isLoading = true;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        // Push to login;
        showSpinner = true;
        Navigator.pushNamedAndRemoveUntil(
            context, LoginScreen.id, (route) => false);
      }
      setState(() {
        _isLoading = false;
      });
    });
    return Container(
      child: _isLoading
          ? Scaffold(
              body: ModalProgressHUD(
              inAsyncCall: showSpinner,
              child: Row(),
            ))
          : widget.screen,
    );
  }
}
