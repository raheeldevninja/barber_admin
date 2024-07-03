import 'package:barber_admin/core/extension/context.dart';
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
        style: context.textTheme.bodyMedium,
        children: [
          TextSpan(
            text: linkLabel,
            style: context.textTheme.titleSmall,
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
