import 'package:flutter/material.dart';
import 'headphone_login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // Switch to DrawerPage() or LoginPageTwo() to see the other designs
      home: HeadphoneLoginPage(),
    );
  }
}
