
import 'package:flutter/material.dart';
import 'package:thelostlane/authentication/google_authentication.dart';
import 'package:thelostlane/views/login_screen.dart';

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () async {
            await GoogleAuthenticationService().signOutGoogle();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          },
          child: Text("Sign Out"),
        ),
      ),
    );
  }
}