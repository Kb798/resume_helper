import 'package:flutter/material.dart';
import 'package:resume_helper/screens/splash_screen.dart';
import 'package:resume_helper/utils/app_colors.dart';

import 'model/user_resume_model.dart';

void main() {
  runApp( MyApp());
}

UserResumeModel userResumeModel=UserResumeModel();
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  MaterialColor primaryMain = MaterialColor(AppColors.clrMain.value, {
    50:  Color(AppColors.clrMain.value).withOpacity(0.1),
    100:  Color(AppColors.clrMain.value).withOpacity(0.2),
    200:  Color(AppColors.clrMain.value).withOpacity(0.3),
    300:  Color(AppColors.clrMain.value).withOpacity(0.4),
    400:  Color(AppColors.clrMain.value).withOpacity(0.5),
    500:  Color(AppColors.clrMain.value).withOpacity(0.6),
    600:  Color(AppColors.clrMain.value).withOpacity(0.7),
    700:  Color(AppColors.clrMain.value).withOpacity(0.8),
    800:  Color(AppColors.clrMain.value).withOpacity(0.9),
    900:  Color(AppColors.clrMain.value).withOpacity(1),
  });
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resume Helper',
      theme: ThemeData(
        primarySwatch: primaryMain,
      ),
      home:  SplashScreen(),
    );
  }
}

