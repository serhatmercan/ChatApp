import 'package:ChatApp/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (ctx, futureSnapshot) {
      if (futureSnapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else {
        return StreamBuilder(
          stream: FirebaseFirestore.instance.collection("chat").orderBy("createdAt", descending: true).snapshots(),
          builder: (BuildContext ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
            if (chatSnapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              final chatDocs = chatSnapshot.data.docs;
              return FutureBuilder(
                builder: (ctx, futureSnapshot) {
                  return ListView.builder(
                    reverse: true,
                    itemCount: chatDocs.length,
                    itemBuilder: (ctx, index) => MessageBubble(
                      chatDocs[index]["text"],
                      chatDocs[index]["username"],
                      chatDocs[index]["userImage"],
                      chatDocs[index]["userId"] == FirebaseAuth.instance.currentUser.uid,
                      key: ValueKey(chatDocs[index].id),
                    ),
                  );
                },
              );
            }
          },
        );
      }
    });
  }
}
