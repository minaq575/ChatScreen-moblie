import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:week8/firebase_options.dart';
import 'package:week8/screens/chat_screen.dart';
import 'package:week8/screens/main_screen.dart';
import 'package:week8/screens/registry_screen.dart';
import 'package:week8/screens/sing_in_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue),
      initialRoute: MainScreen.id,
      routes: {
        ChatScreen.id: (context) => const ChatScreen(),
        MainScreen.id: (context) => const MainScreen(),
        RegistryScreen.id: (context) => const RegistryScreen(),
        SignInScreen.id: (context) => const SignInScreen(),
      },
    );
  }
}
