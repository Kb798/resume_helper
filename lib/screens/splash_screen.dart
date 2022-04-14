import 'dart:async';

import 'package:flutter/material.dart';
import 'package:resume_helper/screens/personal_info_screen.dart';
import 'package:resume_helper/utils/app_images.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  startTime() async {
    var _duration = const Duration(seconds: 2);
    return Timer(_duration, navigationPage);
  }

  Future navigationPage() async {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const PersonalInfoScreen()));
  }

  @override
  initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Center(
          child: Image.asset(AppImages.imgLogo,
              height: MediaQuery.of(context).size.width * 0.50)),
    ));
  }
}
