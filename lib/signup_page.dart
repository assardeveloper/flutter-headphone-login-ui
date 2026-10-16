import 'package:flutter/material.dart';

import 'animations.dart';
import 'login_widgets.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            signUpHeader(context, () => Navigator.pop(context)),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.only(left: 20),
                    child: welcomeText(
                      "Sign Up",
                      "Create an account to get started",
                    ),
                  ),
                  SizedBox(height: 36),
                  roundedField("Full Name"),
                  SizedBox(height: 18),
                  roundedField("Phone or Email"),
                  SizedBox(height: 18),
                  roundedField("Password", isPassword: true),
                  SizedBox(height: 18),
                  roundedField("Confirm Password", isPassword: true),
                  SizedBox(height: 14),
                  TermsCheck(),
                  SizedBox(height: 22),
                  primaryButton("Sign Up", () {}),
                  SizedBox(height: 24),
                  Padding(
                    padding: EdgeInsetsGeometry.only(left: 20),
                    child: signUpText(
                      "Already have an account ? ",
                      "Log In",
                      () => Navigator.pop(context),
                    ),
                  ),
                  SizedBox(height: 36),
                  orText("Or sign up with"),
                  SizedBox(height: 18),
                  socialRow(),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Smaller version of the login header, with a back button on the left
Widget signUpHeader(BuildContext context, VoidCallback onBack) {
  final width = MediaQuery.of(context).size.width;
  final top = MediaQuery.of(context).padding.top;
  return SizedBox(
    width: width,
    height: width * 0.42,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -width * 0.2,
          left: width * 0.42,
          child: FadeSlideIn(
            offset: const Offset(0, -80),
            duration: const Duration(milliseconds: 900),
            child: Floating(
              distance: 6,
              duration: const Duration(seconds: 6),
              child: circle(width * 0.5, kTealLight),
            ),
          ),
        ),
        Positioned(
          top: -width * 0.1,
          left: width * 0.6,
          child: FadeSlideIn(
            delay: const Duration(milliseconds: 150),
            offset: const Offset(80, 0),
            duration: const Duration(milliseconds: 900),
            child: Container(
              width: width * 0.55,
              height: width * 0.55,
              decoration: const BoxDecoration(
                color: kTeal,
                shape: BoxShape.circle,
              ),
              alignment: const Alignment(-0.3, 0.25),
              child: FadeSlideIn(
                delay: const Duration(milliseconds: 600),
                duration: const Duration(milliseconds: 1200),
                offset: Offset.zero,
                scale: 0,
                curve: Curves.elasticOut,
                child: Floating(
                  distance: 6,
                  duration: const Duration(seconds: 3),
                  child: kidAvatar(width * 0.24),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: top + 8,
          left: 16,
          child: Pressable(
            onTap: onBack,
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: kBorder, width: 1.5),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: kText,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// "I agree to the Terms & Privacy Policy" with a round check
class TermsCheck extends StatefulWidget {
  const TermsCheck({super.key});

  @override
  State<TermsCheck> createState() => _TermsCheckState();
}

class _TermsCheckState extends State<TermsCheck> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _checked = !_checked),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: _checked ? kTeal : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: _checked ? kTeal : kBorder,
                  width: 1.5,
                ),
              ),
              child: _checked
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Text.rich(
                TextSpan(
                  style: TextStyle(color: kText, fontSize: 13),
                  children: [
                    TextSpan(text: 'I agree to the '),
                    TextSpan(
                      text: 'Terms',
                      style: TextStyle(
                        color: kTeal,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(text: ' & '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                        color: kTeal,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
