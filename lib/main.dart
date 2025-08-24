// ignore: depend_on_referenced_packages, unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_signup/features/authentication/login/presentation/screens/login_screen.dart';
import 'package:login_signup/features/authentication/signup/presentation/screens/signup_screen.dart';
import 'package:login_signup/core/theme/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_signup/features/home/presentation/screens/dashboard_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Example login
  try {
    UserCredential _ = await FirebaseAuth.instance.signInAnonymously();
    if (kDebugMode) {
      print("Signed in with temporary account.");
    }

    // Now Firestore works, for example, you can add a user.
    // This is just an example, you might want to move this logic to a more appropriate place.
    // FirebaseFirestore.instance.collection('users').add({
    //   'name': 'Test User',
    //   'uid': userCredential.user?.uid,
    // });

  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case "operation-not-allowed":
        if (kDebugMode) {
          print("Anonymous auth hasn't been enabled for this project.");
        }
        break;
      default:
        if (kDebugMode) {
          print("Unknown error.");
        }
    }
  }

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
      home: const DashboardScreen(),
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
