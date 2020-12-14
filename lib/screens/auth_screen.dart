import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ChatApp/widgets/auth_form.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  void _submitAuthForm(String email, String password, String username, bool isLogin, BuildContext ctx) async {
    UserCredential userCredential;

    try {
      if (isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      }
    } on PlatformException catch (e) {
      var message = "";

      if (e.message == null) {
        message = "An error occured, please check your creadentials!";
      } else {
        message = e.message;
      }

      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text(message),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm),
    );
  }
}
