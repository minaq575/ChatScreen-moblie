// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:week8/components/chat/chat_message.dart';

// ignore: must_be_immutable
class ChatListView extends StatelessWidget {
  ChatListView({super.key, required this.user, required this.snapshot});
  AsyncSnapshot<QuerySnapshot> snapshot;
  User? user;

  @override
  Widget build(BuildContext context) {
    return ListView(
      reverse: true,
      children: snapshot.data!.docs.map((DocumentSnapshot documentSnapshot) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        bool isMe = user!.email == data['serder'];
        return Padding(
          padding: const EdgeInsets.all(0.5),
          child: ChatMessage(data: data, isMe: isMe),
        );
      }).toList(),
    );
  }
}
