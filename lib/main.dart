import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:thelostlane/models/category.dart';
import 'package:thelostlane/models/place_model.dart';
import 'package:thelostlane/views/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
