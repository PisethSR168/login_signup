import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_signup/main.dart';

void main() {
  testWidgets('Login screen renders correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const MyHomeApp());

    // Verify login screen components exist
    expect(find.text('Login'), findsOneWidget); // AppBar title
    expect(find.text('Phone number, email or username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('LOGIN'), findsOneWidget);
    expect(find.text('Forgot your login details? Get help'), findsOneWidget);
    expect(find.text('OR'), findsOneWidget);
    expect(find.text('Login with google'), findsOneWidget);
    expect(find.text('Login with facebook'), findsOneWidget);
    expect(find.text("Does't have account?"), findsOneWidget);
    expect(find.text('Create new account'), findsOneWidget);
  });

  testWidgets('Navigate to signup screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyHomeApp());

    // Tap the 'Create new account' button
    await tester.tap(find.text('Create new account'));
    await tester.pumpAndSettle();

    // Verify we're on the signup screen
    expect(find.text('Sign Up'), findsOneWidget); // AppBar title
    expect(find.text('Full Name'), findsOneWidget);
    expect(find.text('Email Address'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('CREATE ACCOUNT'), findsOneWidget);
    expect(find.text('Already have account?'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('Social buttons are present', (WidgetTester tester) async {
    await tester.pumpWidget(const MyHomeApp());

    // Verify social buttons exist
    expect(find.byType(OutlinedButton), findsNWidgets(2));
    expect(find.text('Login with google'), findsOneWidget);
    expect(find.text('Login with facebook'), findsOneWidget);
  });
}
