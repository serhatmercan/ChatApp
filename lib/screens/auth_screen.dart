import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ChatApp/widgets/auth/auth_form.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String username,
    File image,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential userCredential;

    try {
      setState(() {
        _isLoading = true;
      });

      if (isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      }

      final ref = FirebaseStorage.instanceFor().ref().child("user_image").child(userCredential.user.uid + ".jpg");

      await ref.putFile(image).whenComplete(() => null);

      final url = await ref.getDownloadURL();

      await FirebaseFirestore.instance.collection("users").doc(userCredential.user.uid).set({
        "username": username,
        "email": email,
        "image_url": url,
      });

      setState(() {
        _isLoading = false;
      });
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

      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      if (err.message != null) {
        Scaffold.of(ctx).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).errorColor,
            content: Text(err.message),
          ),
        );
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}
