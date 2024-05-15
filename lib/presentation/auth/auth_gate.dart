

import 'package:connectapp/presentation/screens/body_view.dart';
import 'package:connectapp/presentation/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () {
      checkAuthState();
    });
    super.initState();
  }

  void checkAuthState() {
    User? user = _auth.currentUser;
    if (user != null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => BodyView())));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => SplashScreen())));//check and change SplashScreen to signup.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
