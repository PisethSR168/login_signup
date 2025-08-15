// ignore: depend_on_referenced_packages
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_signup/signup_screen.dart';
import 'login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(
    DevicePreview(
      builder: (context) => const MyHomeApp(),
      enabled: true,
      tools: [...DevicePreview.defaultTools],
    ),
  );
}

class MyHomeApp extends StatelessWidget {
  const MyHomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth App',
      home: const LoginScreen(),
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.bgColor,
          titleTextStyle: TextStyle(color: AppColors.white, fontSize: 20),
          iconTheme: IconThemeData(color: AppColors.white),
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
      },
    );
  }
}

class AppColors {
  static const Color bgColor = Color(0xff78C9FF);
  static const Color textFieldBg = Color(0xffE8E8E8);
  static const Color primaryButton = Colors.blue;
  static const Color facebookBlue = Color(0xff0866ff);
  static const Color dividerColor = Color(0xffA2A2A2);
  static const Color white = Colors.white;
}
