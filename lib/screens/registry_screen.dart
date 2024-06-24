// ignore_for_file: unused_field, unused_element, unused_local_variable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:week8/components/user_image_picker.dart';
import 'package:week8/screens/chat_screen.dart';
import 'dart:developer' as dev;
import '../components/my_button.dart';
import '../components/my_text_input.dart';
import 'package:path/path.dart' as p;

class RegistryScreen extends StatefulWidget {
  static const id = 'registry_screen';
  const RegistryScreen({super.key});

  @override
  State<RegistryScreen> createState() => _RegistryScreenState();
}

class _RegistryScreenState extends State<RegistryScreen> {
  final _auth = FirebaseAuth.instance;
  late File _avater;
  late String email;
  late String password;
  late String username;

  void _pickedImageFile({required File pickedImageFile}) {
    _avater = pickedImageFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registry Screen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  height: 60,
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Create a new account',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          ),
          UserImagePicker(
            callback: _pickedImageFile,
          ),
          const SizedBox(
            height: 20,
          ),
          MyTextInput(
              hintText: 'Enter Username',
              keyboardType: TextInputType.text,
              onChanged: (value) {
                username = value;
              }),
          MyTextInput(
              hintText: 'Enter Email',
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                email = value;
              }),
          MyTextInput(
              hintText: 'Enter Password',
              keyboardType: TextInputType.visiblePassword,
              onChanged: (value) {
                password = value;
              }),
          MyButton(
            label: "Next",
            onPressed: () async {
              try {
                UserCredential userCredential =
                    await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                if (userCredential.user != null) {
                  String? avatarUrl;
                  try {
                    String ext = p.extension(_avater.path);
                    String filenames = '${userCredential.user!.uid}$ext';
                    final storageRef = FirebaseStorage.instance.ref();
                    final avaterRef = storageRef
                        .child(filenames)
                        .child('user_avatar')
                        .child(filenames);
                    await avaterRef.putData(
                      _avater.readAsBytesSync(),
                      SettableMetadata(contentType: 'image/$ext'),
                    );
                    avatarUrl = await avaterRef.getDownloadURL();
                  } on FirebaseException catch (e) {
                    dev.log(e.toString());
                  }
                  await FirebaseFirestore.instance
                      .collection('user')
                      .doc(email)
                      .set({
                    'username': username,
                    'uid': userCredential.user!.uid,
                    'avater_url': avatarUrl,
                  });
                  if (!mounted) return;
                  Navigator.pushNamed(context, ChatScreen.id);
                }
              } on FirebaseAuthException catch (e) {
                if (e.code == "week-password") {
                  dev.log('The password provided is too weak');
                } else if (e.code == 'email-already-in-use') {
                  dev.log('The account already exists for that email');
                } else {
                  dev.log(e.toString());
                }
              } catch (e) {
                dev.log(e.toString());
              }
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
