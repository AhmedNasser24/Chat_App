import 'package:flutter/material.dart';

import '../constants.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.textMessage,
     required this.isMe,
  });
  final String textMessage;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(
            left: isMe ? 12 : 45, top: 12, right: isMe ? 45 : 12, bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isMe ? kPrimaryColor : const Color.fromARGB(255, 83, 100, 83),
          borderRadius:  BorderRadius.only(
            bottomLeft: isMe ?  Radius.circular(0) : Radius.circular(24),
          
            bottomRight: isMe ?  Radius.circular(24) : Radius.circular(0),
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Text(
          textMessage,
          style: const TextStyle(
            color: kSecondaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
