import 'package:flutter/material.dart';
import 'package:get/get.dart'; // ✅ ADD THIS
import 'package:firebase_core/firebase_core.dart';
import 'package:instagram_clone/screen/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // 🔥 CHANGE HERE
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
