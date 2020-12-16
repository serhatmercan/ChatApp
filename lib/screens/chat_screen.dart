import 'package:ChatApp/widgets/chat/messages.dart';
import 'package:ChatApp/widgets/chat/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        actions: [
          buildDropdownButton(),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ),
      ),
    );
  }

  DropdownButton<String> buildDropdownButton() {
    return DropdownButton(
      icon: Icon(Icons.more_vert),
      underline: Container(),
      items: [
        buildDropdownMenuItem(),
      ],
      onChanged: (itemID) {
        if (itemID == "logout") {
          FirebaseAuth.instance.signOut();
        }
      },
    );
  }

  DropdownMenuItem<String> buildDropdownMenuItem() {
    return DropdownMenuItem(
      value: "logout",
      child: Container(
        child: Row(
          children: [
            Icon(Icons.exit_to_app),
            SizedBox(width: 8),
            Text("Logout"),
          ],
        ),
      ),
    );
  }
}
