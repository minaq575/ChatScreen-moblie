import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:week8/components/chat/message/sender/sender_name_text.dart';

class MessageSenderName extends StatelessWidget {
  const MessageSenderName({
    Key? key,
    required this.data,
  }) : super(key: key);
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    String email = data['serder'];
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('user').doc(email).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const SenderNameText(
            sendername: 'unnamed',
          );
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return const SenderNameText(
            sendername: 'unnamed',
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return SenderNameText(
            sendername: data['username'],
          );
        }
        return const SizedBox(
          width: 15,
          height: 15,
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
