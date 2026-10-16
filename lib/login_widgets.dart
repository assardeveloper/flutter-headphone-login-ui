import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'animations.dart';

// Colors used in the whole UI
const Color kTeal = Color(0xFF41959C);
const Color kTealLight = Color(0xFF52B5C1);
const Color kTealDark = Color(0xFF2E7F86);
const Color kText = Color(0xFF6B6B6B);
const Color kBorder = Color(0xFFA9A9A9);
const Color kKidDark = Color(0xFF2F2F3A);
const Color kKidBlue = Color(0xFF6FA8D6);

// Two teal circles in the top right corner with the kid inside
Widget headerCircles(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  return SizedBox(
    width: width,
    height: width * 0.55,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -width * 0.14,
          left: width * 0.29,
          child: FadeSlideIn(
            offset: const Offset(0, -80),
            duration: const Duration(milliseconds: 900),
            child: Floating(
              distance: 6,
              duration: const Duration(seconds: 6),
              child: circle(width * 0.65, kTealLight),
            ),
          ),
        ),
        Positioned(
          top: -width * 0.03,
          left: width * 0.5,
          child: FadeSlideIn(
            delay: const Duration(milliseconds: 150),
            offset: const Offset(80, 0),
            duration: const Duration(milliseconds: 900),
            child: Container(
              width: width * 0.72,
              height: width * 0.72,
              decoration: const BoxDecoration(
                color: kTeal,
                shape: BoxShape.circle,
              ),
              alignment: const Alignment(-0.35, 0.05),
              child: FadeSlideIn(
                delay: const Duration(milliseconds: 600),
                duration: const Duration(milliseconds: 1200),
                offset: Offset.zero,
                scale: 0,
                curve: Curves.elasticOut,
                child: Floating(
                  distance: 6,
                  duration: const Duration(seconds: 3),
                  child: kidAvatar(width * 0.32),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// Plain filled circle
Widget circle(double size, Color color) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}

// Cartoon kid with a beanie, drawn with CustomPaint
Widget kidAvatar(double size) {
  return CustomPaint(size: Size(size, size), painter: KidPainter());
}

class KidPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    final outline = Paint()
      ..color = kKidDark
      ..style = PaintingStyle.stroke
      ..strokeWidth = s * 0.035
      ..strokeCap = StrokeCap.round;
    Paint fill(Color color) => Paint()..color = color;

    // Face
    final faceCenter = Offset(s * 0.5, s * 0.6);
    canvas.drawCircle(faceCenter, s * 0.3, fill(Colors.white));
    canvas.drawCircle(faceCenter, s * 0.3, outline);

    // Beanie top
    final dome = Rect.fromLTRB(s * 0.24, s * 0.1, s * 0.76, s * 0.5);
    canvas.drawArc(dome, math.pi, math.pi, true, fill(const Color(0xFFE6EEF6)));
    canvas.drawArc(dome, math.pi, math.pi, false, outline);

    // Beanie band
    final band = RRect.fromRectAndRadius(
      Rect.fromLTRB(s * 0.18, s * 0.26, s * 0.82, s * 0.4),
      Radius.circular(s * 0.07),
    );
    canvas.drawRRect(band, fill(kKidBlue));
    canvas.drawRRect(band, outline);

    // Pompom
    final pompom = Offset(s * 0.5, s * 0.07);
    canvas.drawCircle(pompom, s * 0.07, fill(kKidBlue));
    canvas.drawCircle(pompom, s * 0.07, outline);

    // Eyes
    canvas.drawCircle(Offset(s * 0.4, s * 0.58), s * 0.03, fill(kKidDark));
    canvas.drawCircle(Offset(s * 0.6, s * 0.58), s * 0.03, fill(kKidDark));

    // Cheeks
    final blush = fill(const Color(0xFFF28B9A));
    canvas.drawCircle(Offset(s * 0.31, s * 0.68), s * 0.04, blush);
    canvas.drawCircle(Offset(s * 0.69, s * 0.68), s * 0.04, blush);

    // Smile
    canvas.drawArc(
      Rect.fromCircle(center: Offset(s * 0.5, s * 0.64), radius: s * 0.08),
      0.2 * math.pi,
      0.6 * math.pi,
      false,
      outline,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// "Welcome" heading + subtitle
Widget welcomeText(String title, String subtitle) {
  return FadeSlideIn(
    delay: const Duration(milliseconds: 300),
    offset: const Offset(-40, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: kTeal,
            fontSize: 36,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Text(subtitle, style: const TextStyle(color: kText, fontSize: 13)),
      ],
    ),
  );
}

// Pill shaped text field, border turns teal when focused
Widget roundedField(String hint, {bool isPassword = false}) {
  return RoundedField(hint: hint, isPassword: isPassword);
}

class RoundedField extends StatefulWidget {
  const RoundedField({super.key, required this.hint, this.isPassword = false});

  final String hint;
  final bool isPassword;

  @override
  State<RoundedField> createState() => _RoundedFieldState();
}

class _RoundedFieldState extends State<RoundedField> {
  final _focusNode = FocusNode();
  bool _focused = false;
  late bool _obscure = widget.isPassword;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => _focused = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: 58,
      padding: const EdgeInsets.only(left: 22, right: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: _focused ? kTeal : kBorder, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: kTeal.withValues(alpha: _focused ? 0.2 : 0),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: TextField(
        focusNode: _focusNode,
        obscureText: _obscure,
        cursorColor: kTeal,
        style: const TextStyle(color: Colors.black87, fontSize: 14),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: const TextStyle(color: kText, fontSize: 14),
          border: InputBorder.none,
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () => setState(() => _obscure = !_obscure),
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    transitionBuilder: (child, animation) =>
                        ScaleTransition(scale: animation, child: child),
                    child: Icon(
                      _obscure ? Icons.visibility : Icons.visibility_off,
                      key: ValueKey(_obscure),
                      color: const Color(0xFF3A3A3A),
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

// "Forgot Password" on the right side
Widget forgotPassword(VoidCallback onTap) {
  return Align(
    alignment: Alignment.centerRight,
    child: Pressable(
      onTap: onTap,
      child: const Padding(
        padding: EdgeInsets.only(right: 20),
        child: Text(
          'Forgot Password',
          style: TextStyle(color: kText, fontSize: 13),
        ),
      ),
    ),
  );
}

// Full width teal pill button
Widget primaryButton(String text, VoidCallback onTap) {
  return Pressable(
    onTap: onTap,
    pressedScale: 0.95,
    child: Container(
      height: 58,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: kTeal,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: kTeal.withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

// "Don't have an account ? Sign Up"
Widget signUpText(String question, String action, VoidCallback onTap) {
  return Row(
    children: [
      Text(question, style: const TextStyle(color: kText, fontSize: 13)),
      Pressable(
        onTap: onTap,
        child: Text(
          action,
          style: const TextStyle(
            color: kTeal,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ],
  );
}

// "- Or log in with -"
Widget orText(String text) {
  return Center(
    child: Text(
      '- $text -',
      style: const TextStyle(color: kText, fontSize: 13),
    ),
  );
}

// One pill shaped social button, [filled] makes it teal
Widget socialButton(
  String label,
  Widget icon,
  Color color, {
  bool filled = false,
  VoidCallback? onTap,
}) {
  return Expanded(
    child: Pressable(
      onTap: onTap ?? () {},
      pressedScale: 0.88,
      child: Container(
        height: 52,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: filled ? kTeal : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: filled ? kTeal : kBorder, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: filled ? Colors.white : color,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// Google, Facebook and Twitter buttons in a row
Widget socialRow() {
  return Row(
    children: [
      socialButton(
        'Google',
        const Text(
          'G+',
          style: TextStyle(
            color: Color(0xFFDB4437),
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
        const Color(0xFFDB4437),
      ),
      socialButton(
        'Facebook',
        const Icon(Icons.facebook, color: Colors.white, size: 22),
        Colors.white,
        filled: true,
      ),
      socialButton(
        'Twitter',
        const Icon(Icons.flutter_dash, color: Color(0xFF1DA1F2), size: 24),
        const Color(0xFF1DA1F2),
      ),
    ],
  );
}
