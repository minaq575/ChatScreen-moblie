import 'package:flutter/material.dart';
import 'package:week8/components/chat/message/message_sender_name.dart';
import 'package:week8/components/chat/message/message_text.dart';
import 'package:week8/components/chat/message/message_timestamp.dart';

// ignore: must_be_immutable
class ChatMessage extends StatelessWidget {
  ChatMessage({super.key, required this.data, required this.isMe});
  Map<String, dynamic> data;
  bool isMe;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        MessageSenderName(data: data),
        MessageText(data: data, isMe: isMe),
        MessageTimestamp(data: data),
      ],
    );
  }
}
