import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:week8/components/chat/ChatListView.dart';

// ignore: must_be_immutable
class ChatStreamBuilder extends StatelessWidget {
  Stream<QuerySnapshot<Object?>> messageStream;
  User? user;
  ChatStreamBuilder(
      {super.key, required this.user, required this.messageStream});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('somthing went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading');
        }
        return Expanded(
          child: ChatListView(
            snapshot: snapshot,
            user: user,
          ),
        );
      },
      stream: messageStream,
    );
  }
}
