import 'dart:developer' as dev;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:week8/components/input_with_error_text.dart';
import 'package:week8/components/my_button.dart';
import 'package:week8/components/my_text_input_with_error_text.dart';
import 'package:week8/screens/chat_screen.dart';

class SignInScreen extends StatefulWidget {
  static const id = 'sing_in_screen';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final InputWithErrorText _email = InputWithErrorText();
  final InputWithErrorText _password = InputWithErrorText();
  // late String email;
  // late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In Screen'),
      ),
      body: ProgressHUD(
        child: Builder(
          builder: (context) => Column(
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
                        'Sign-in',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextInputWithErrorText(
                  input: _email,
                  hintText: 'Enter Email',
                  keyboardType: TextInputType.emailAddress),
              MyTextInputWithErrorText(
                input: _password,
                hintText: 'Enter Password',
                keyboardType: TextInputType.text,
                obscureText: true,
              ),
              MyButton(
                label: 'Naxt',
                onPressed: () async {
                  // ignore: non_constant_identifier_names
                  final Progress = ProgressHUD.of(context);
                  Progress?.showWithText('Loading..');
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _email.valueText, password: _password.valueText);
                    if (!mounted) return;
                    Navigator.pushNamed(context, ChatScreen.id);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == "user-not-found") {
                      _email.errorText = 'user-not-found';
                    }
                    if (e.code == "wrong-password") {
                      _password.errorText =
                          'wrong password ${_password.valueText}';
                    }
                    dev.log(e.toString());
                  }
                  setState(() {});
                  Progress?.dismiss();
                },
              )
            ],
          ),
        ),
      ),
    );
    // );
  }
}
