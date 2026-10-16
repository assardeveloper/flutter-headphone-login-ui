import 'package:flutter/material.dart';

import 'headphone_widgets.dart';

class HeadphoneLoginPage extends StatelessWidget {
  const HeadphoneLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLime,
      body: Stack(
        children: [
          Positioned.fill(child: HeadphonePattern()),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  SizedBox(height: 50),
                  const HeadphoneImage(size: 150),
                  SizedBox(height: 40),
                  Text(
                    "Headphone",
                    style: quicksand(40, weight: FontWeight.w700),
                  ),
                  SizedBox(height: 56),
                  const HeadphoneField(
                    hint: "Email Address",
                    icon: Icons.email,
                  ),
                  SizedBox(height: 20),
                  const HeadphoneField(
                    hint: "Password",
                    icon: Icons.lock,
                    isPassword: true,
                  ),
                  SizedBox(height: 22),
                  forgotPasswordLink(() {}),
                  SizedBox(height: 36),
                  blackButton("Login", () {}),
                  SizedBox(height: 40),
                  continueWithDivider("Or contiune with"),
                  SizedBox(height: 26),
                  socialButtons(),
                  SizedBox(height: 30),
                  signUpPrompt(() {}),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
