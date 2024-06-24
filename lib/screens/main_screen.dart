import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:week8/screens/registry_screen.dart';
import 'package:week8/screens/sing_in_screen.dart';

import '../components/NavigationButton.dart';

class MainScreen extends StatefulWidget {
  static const id = 'main_screen';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;
  late Animation animationColor;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      // upperBound: 100,
      // lowerBound:  20,
    );
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.bounceIn);
    animationColor = ColorTween(begin: Colors.white, end: Colors.purple)
        .animate(animationController);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse(from: 2);
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
    animationController.forward();
    animationController.addListener(() {
      // log(animationController.value.toStringAsFixed(3));
      setState(() {});
    });
  }

  @override
  void dispose() {
    animationController.dispose(); //ทำรายตัวเอง
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MainScreen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: SizedBox(
              height: animationController.value * 60,
              child: Hero(
                tag: 'logo',
                child: Image.asset('images/logo.png'),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Rocket Chat',
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: animationColor.value,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const NavigationButton(
            label: "Sign-in",
            routeName: SignInScreen.id,
          ),
          const NavigationButton(
            label: "Create an account",
            routeName: RegistryScreen.id,
          )
        ],
      ),
    );
  }
}
