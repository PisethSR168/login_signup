// ignore: depend_on_referenced_packages
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_signup/features/authentication/login/presentation/screens/login_screen.dart';
import 'package:login_signup/features/authentication/signup/presentation/screens/signup_screen.dart';
import 'package:login_signup/core/theme/app_colors.dart';

import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 
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


