import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignInSignUpLink extends StatelessWidget {
  const SignInSignUpLink({
    required this.label,
    required this.linkLabel,
    required this.onTap,
    super.key,
  });

  final String label;
  final String linkLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: label,
        style: const TextStyle(color: Colors.black),
        children: [
          TextSpan(
            text: linkLabel,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                onTap();
              },
          ),
        ],
      ),
    );
  }
}
