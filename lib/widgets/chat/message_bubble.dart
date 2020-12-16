import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this.message, this.username, this.userImage, this.isMe, {this.key});

  final String message;
  final String username;
  final String userImage;
  final bool isMe;
  final Key key;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: isMe ? Radius.circular(12) : Radius.circular(0),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                ),
                color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
              ),
              margin: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              width: 140,
              child: Column(
                crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                      color: isMe ? Colors.black : Theme.of(context).accentTextTheme.headline1.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: isMe ? Colors.black : Theme.of(context).accentTextTheme.headline1.color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          left: isMe ? null : 120,
          right: isMe ? 120 : null,
          top: 0,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          ),
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}
