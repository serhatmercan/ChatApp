import 'package:ChatApp/screens/auth_screen.dart';
import 'package:ChatApp/screens/chat_screen.dart';
import 'package:ChatApp/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: buildThemeData(context),
      home: buildStreamBuilder(),
    );
  }

  ThemeData buildThemeData(BuildContext context) {
    return ThemeData(
      accentColor: Colors.blue,
      accentColorBrightness: Brightness.dark,
      backgroundColor: Colors.green,
      buttonTheme: ButtonTheme.of(context).copyWith(
        buttonColor: Colors.green,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      primarySwatch: Colors.green,
    );
  }

  StreamBuilder<User> buildStreamBuilder() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen();
        }
        if (snapshot.hasData) {
          return ChatScreen();
        } else {
          return AuthScreen();
        }
      },
    );
  }
}
