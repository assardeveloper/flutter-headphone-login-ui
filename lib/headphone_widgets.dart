import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

// Colors for the headphone login design
const Color kLime = Color(0xFFD4F200);
const Color kInk = Color(0xFF151612);
const Color kInkSoft = Color(0xFF3A3D2E);

TextStyle quicksand(double size, {FontWeight weight = FontWeight.w500, Color color = kInk}) {
  return GoogleFonts.quicksand(fontSize: size, fontWeight: weight, color: color);
}

// The headphone image is a transparent silhouette, so srcIn paints it in
// [color] while keeping the transparent background transparent
class HeadphoneImage extends StatelessWidget {
  const HeadphoneImage({super.key, required this.size, this.color = Colors.black});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      child: Image.asset('assets/images/headphone.png', width: size),
    );
  }
}

// Faint headphone images tiled behind the whole page
class HeadphonePattern extends StatelessWidget {
  const HeadphonePattern({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const double gap = 80;
        final cols = (constraints.maxWidth / gap).ceil() + 1;
        final rows = (constraints.maxHeight / gap).ceil() + 1;
        final icons = <Widget>[];
        for (int r = 0; r < rows; r++) {
          for (int c = 0; c < cols; c++) {
            // every other column is pushed down a bit to stagger the pattern
            final top = r * gap + (c.isOdd ? 14 : 0);
            icons.add(
              Positioned(
                left: c * gap + 16,
                top: top + 20,
                child: HeadphoneImage(
                  size: 34,
                  color: Colors.black.withValues(alpha: 0.035),
                ),
              ),
            );
          }
        }
        return Stack(children: icons);
      },
    );
  }
}

// White rounded input with an icon, a thin divider and an optional eye toggle
class HeadphoneField extends StatefulWidget {
  const HeadphoneField({
    super.key,
    required this.hint,
    required this.icon,
    this.isPassword = false,
  });

  final String hint;
  final IconData icon;
  final bool isPassword;

  @override
  State<HeadphoneField> createState() => _HeadphoneFieldState();
}

class _HeadphoneFieldState extends State<HeadphoneField> {
  bool _hidden = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Icon(widget.icon, color: Colors.black, size: 24),
          Container(
            width: 1,
            height: 28,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            color: Colors.black12,
          ),
          Expanded(
            child: TextField(
              obscureText: widget.isPassword && _hidden,
              cursorColor: const Color(0xFF3D5AFE),
              keyboardType: widget.isPassword
                  ? TextInputType.visiblePassword
                  : TextInputType.emailAddress,
              style: quicksand(18),
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: quicksand(18, color: kInkSoft),
                border: InputBorder.none,
                isCollapsed: true,
              ),
            ),
          ),
          if (widget.isPassword)
            GestureDetector(
              onTap: () => setState(() => _hidden = !_hidden),
              child: Icon(
                _hidden ? Icons.visibility_off : Icons.visibility,
                color: Colors.black,
                size: 24,
              ),
            ),
        ],
      ),
    );
  }
}

Widget forgotPasswordLink(VoidCallback onTap) {
  return Align(
    alignment: Alignment.centerRight,
    child: GestureDetector(
      onTap: onTap,
      child: Text(
        "Forgot Password?",
        style: quicksand(16, weight: FontWeight.w700),
      ),
    ),
  );
}

Widget blackButton(String text, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 70,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: kInk,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Text(
        text,
        style: quicksand(22, weight: FontWeight.w700, color: Colors.white),
      ),
    ),
  );
}

Widget continueWithDivider(String text) {
  return Row(
    children: [
      Expanded(child: Container(height: 1, color: Colors.black26)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Text(text, style: quicksand(16, color: kInkSoft)),
      ),
      Expanded(child: Container(height: 1, color: Colors.black26)),
    ],
  );
}

// Square social button with a white frame around a colored tile
Widget socialTile({
  required Widget icon,
  Color? color,
  Gradient? gradient,
  VoidCallback? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 66,
      height: 66,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          gradient: gradient,
          borderRadius: BorderRadius.circular(14),
        ),
        child: icon,
      ),
    ),
  );
}

Widget socialButtons() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      socialTile(
        color: const Color(0xFF1877F2),
        icon: const FaIcon(FontAwesomeIcons.facebookF, color: Colors.white, size: 30),
      ),
      const SizedBox(width: 16),
      socialTile(
        color: const Color(0xFF4AA8EE),
        icon: const FaIcon(FontAwesomeIcons.twitter, color: Colors.white, size: 28),
      ),
      const SizedBox(width: 16),
      socialTile(
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Color(0xFFFDD835),
            Color(0xFFF56040),
            Color(0xFFE1306C),
            Color(0xFF833AB4),
          ],
        ),
        icon: const FaIcon(FontAwesomeIcons.instagram, color: Colors.white, size: 30),
      ),
      const SizedBox(width: 16),
      socialTile(
        color: const Color(0xFFF43A2F),
        icon: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 34),
      ),
    ],
  );
}

Widget signUpPrompt(VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Text.rich(
      TextSpan(
        text: "Don't have an account? ",
        style: quicksand(17, color: kInkSoft),
        children: [
          TextSpan(
            text: "Sign Up",
            style: quicksand(17, weight: FontWeight.w700),
          ),
        ],
      ),
    ),
  );
}
