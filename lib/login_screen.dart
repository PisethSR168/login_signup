import 'package:flutter/material.dart';
import 'signup_screen.dart'; // Add this import

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
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
                  'images/ProfileBoy.jpg',
                  height: 90,
                  width: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 32),
            TextField(
              decoration: InputDecoration(
                labelText: 'Phone number, email or username',
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
                child: const Text('LOGIN'),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryButton,
              ),
              child: const Text('Forgot your login details? Get help'),
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
              text: 'Login with google',
              color: AppColors.primaryButton,
              onPressed: () {},
            ),
            const SizedBox(height: 16),
            SocialButton(
              icon: Icons.facebook,
              text: 'Login with facebook',
              color: AppColors.facebookBlue,
              onPressed: () {},
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Doesn't have account?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primaryButton,
                  ),
                  child: const Text('Create new account'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const SocialButton({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 16),
        side: BorderSide(color: color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(icon, size: 24), const SizedBox(width: 8), Text(text)],
      ),
    );
  }
}

class AppColors {
  static const Color textFieldBg = Color(0xffE8E8E8);
  static const Color primaryButton = Colors.blue;
  static const Color facebookBlue = Color(0xff0866ff);
  static const Color dividerColor = Color(0xffA2A2A2);

  // ignore: prefer_typing_uninitialized_variables
  static var bgColor;
}
