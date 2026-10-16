import 'package:flutter/material.dart';

import 'animations.dart';
import 'login_widgets.dart' show kidAvatar;

// Colors for this login design
const Color kOrange = Color(0xFFFF7A45);
const Color kOrangeSoft = Color(0xFFFFEDE4);
const Color kNavy = Color(0xFF1E2235);
const Color kGrey = Color(0xFF8A8D9A);
const Color kFieldBg = Color(0xFFF4F5F7);

class LoginPageTwo extends StatelessWidget {
  const LoginPageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
        
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            topBanner(context),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 28),
                  FadeSlideIn(
                    delay: Duration(milliseconds: 250),
                    offset: Offset(0, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Log in",
                          style: TextStyle(
                            color: kNavy,
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "Good to see you again 👋",
                          style: TextStyle(color: kGrey, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 28),
                  LabeledField(
                    label: "Email",
                    hint: "you@example.com",
                    icon: Icons.mail_outline,
                  ),
                  SizedBox(height: 18),
                  LabeledField(
                    label: "Password",
                    hint: "Enter your password",
                    icon: Icons.lock_outline,
                    isPassword: true,
                  ),
                  SizedBox(height: 14),
                  RememberRow(),
                  SizedBox(height: 26),
                  orangeButton("Log in", () {}),
                  SizedBox(height: 26),
                  dividerText("or"),
                  SizedBox(height: 22),
                  outlineButton(
                    "Continue with Google",
                    Text(
                      "G",
                      style: TextStyle(
                        color: Color(0xFFDB4437),
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  outlineButton(
                    "Continue with Apple",
                    Icon(Icons.apple, color: kNavy, size: 24),
                  ),
                  SizedBox(height: 30),
                  Center(child: bottomText()),
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

// Soft orange block at the top with the kid and app name
Widget topBanner(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  final top = MediaQuery.of(context).padding.top;
  return FadeSlideIn(
    offset: const Offset(0, -40),
    child: Container(
      width: width,
      padding: EdgeInsets.fromLTRB(24, top + 16, 24, 24),
      decoration: const BoxDecoration(
        color: kOrangeSoft,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "kiddo",
                    style: TextStyle(
                      color: kOrange,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  "Learn, play\nand grow.",
                  style: TextStyle(
                    color: kNavy,
                    fontSize: 22,
                    height: 1.25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          FadeSlideIn(
            delay: const Duration(milliseconds: 400),
            duration: const Duration(milliseconds: 1100),
            offset: Offset.zero,
            scale: 0,
            curve: Curves.elasticOut,
            child: Floating(
              distance: 5,
              duration: const Duration(seconds: 3),
              child: Container(
                width: width * 0.34,
                height: width * 0.34,
                decoration: const BoxDecoration(
                  color: kOrange,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: kidAvatar(width * 0.22),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// Label above a grey filled field, like most real apps
class LabeledField extends StatefulWidget {
  const LabeledField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.isPassword = false,
  });

  final String label;
  final String hint;
  final IconData icon;
  final bool isPassword;

  @override
  State<LabeledField> createState() => _LabeledFieldState();
}

class _LabeledFieldState extends State<LabeledField> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            color: kNavy,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 54,
          decoration: BoxDecoration(
            color: _focused ? Colors.white : kFieldBg,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _focused ? kOrange : kFieldBg,
              width: 1.5,
            ),
          ),
          alignment: Alignment.center,
          child: TextField(
            focusNode: _focusNode,
            obscureText: _obscure,
            cursorColor: kOrange,
            keyboardType: widget.isPassword
                ? TextInputType.visiblePassword
                : TextInputType.emailAddress,
            style: const TextStyle(color: kNavy, fontSize: 14),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: const TextStyle(color: kGrey, fontSize: 14),
              border: InputBorder.none,
              prefixIcon: Icon(
                widget.icon,
                size: 20,
                color: _focused ? kOrange : kGrey,
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      onPressed: () => setState(() => _obscure = !_obscure),
                      icon: Icon(
                        _obscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20,
                        color: kGrey,
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}

// "Remember me" switch on the left, "Forgot password?" on the right
class RememberRow extends StatefulWidget {
  const RememberRow({super.key});

  @override
  State<RememberRow> createState() => _RememberRowState();
}

class _RememberRowState extends State<RememberRow> {
  bool _remember = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 24,
          child: Transform.scale(
            scale: 0.75,
            alignment: Alignment.centerLeft,
            child: Switch(
              value: _remember,
              activeThumbColor: Colors.white,
              activeTrackColor: kOrange,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: (v) => setState(() => _remember = v),
            ),
          ),
        ),
        const Text("Remember me", style: TextStyle(color: kGrey, fontSize: 13)),
        const Spacer(),
        Pressable(
          onTap: () {},
          child: const Text(
            "Forgot password?",
            style: TextStyle(
              color: kOrange,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

// Full width orange button
Widget orangeButton(String text, VoidCallback onTap) {
  return Pressable(
    onTap: onTap,
    pressedScale: 0.96,
    child: Container(
      height: 54,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: kOrange,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

// Line — text — line
Widget dividerText(String text) {
  return Row(
    children: [
      const Expanded(child: Divider(color: Color(0xFFE3E4E8))),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(text, style: const TextStyle(color: kGrey, fontSize: 13)),
      ),
      const Expanded(child: Divider(color: Color(0xFFE3E4E8))),
    ],
  );
}

// Full width white button with a border and an icon
Widget outlineButton(String text, Widget icon, {VoidCallback? onTap}) {
  return Pressable(
    onTap: onTap ?? () {},
    pressedScale: 0.96,
    child: Container(
      height: 52,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE3E4E8), width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 24, child: Center(child: icon)),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(
              color: kNavy,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}

// "New here? Create an account"
Widget bottomText() {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text("New here? ", style: TextStyle(color: kGrey, fontSize: 13)),
      Pressable(
        onTap: () {},
        child: const Text(
          "Create an account",
          style: TextStyle(
            color: kOrange,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ],
  );
}
