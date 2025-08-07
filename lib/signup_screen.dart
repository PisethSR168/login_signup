import 'package:flutter/material.dart';
import 'package:login_signup/login_screen.dart'; // For SocialButton and AppColors

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: AppColors.bgColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add this for the logo
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue, width: 2),
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/ProfileBoy.jpg',
                  height: 90,
                  width: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              decoration: InputDecoration(
                labelText: 'Full Name',
                filled: true,
                fillColor: AppColors.textFieldBg,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email Address',
                filled: true,
                fillColor: AppColors.textFieldBg,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true,
                fillColor: AppColors.textFieldBg,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryButton,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('CREATE ACCOUNT'),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have account?'),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primaryButton,
                  ),
                  child: const Text('Login'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Divider(color: AppColors.dividerColor, thickness: 1),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'OR',
                    style: TextStyle(color: AppColors.dividerColor),
                  ),
                ),
                Expanded(
                  child: Divider(color: AppColors.dividerColor, thickness: 1),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SocialButton(
              icon: Icons.g_mobiledata,
              text: 'Connect with google',
              color: AppColors.primaryButton,
              onPressed: () {},
            ),
            const SizedBox(height: 16),
            SocialButton(
              icon: Icons.facebook,
              text: 'Connect with facebook',
              color: AppColors.facebookBlue,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
