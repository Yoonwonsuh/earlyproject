import 'package:earlyproject/screens/start/adress_page.dart';
import 'package:earlyproject/screens/start/auth_page.dart';
import 'package:earlyproject/screens/start/intro_page.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  StartScreen({Key? key}) : super(key: key);

  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          // physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            IntroPage(_pageController),
            AdressPage(),
            AuthPage(),
          ]),
    );
  }
}
