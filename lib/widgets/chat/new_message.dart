import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _messageController = new TextEditingController();
  var _enteredMessage = "";

  void _sendMessage() async {
    FocusScope.of(context).unfocus();

    final uid = FirebaseAuth.instance.currentUser.uid;
    final userData = await FirebaseFirestore.instance.collection("users").doc(uid).get();

    FirebaseFirestore.instance.collection("chat").add({
      "text": _enteredMessage,
      "createdAt": Timestamp.now(),
      "userId": uid,
      "username": userData["username"],
      "userImage": userData["image_url"],
    });
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autocorrect: true,
              controller: _messageController,
              decoration: InputDecoration(labelText: "Send a message.."),
              enableSuggestions: true,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(Icons.send),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          ),
        ],
      ),
    );
  }
}
