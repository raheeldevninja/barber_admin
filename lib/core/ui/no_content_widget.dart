import 'package:flutter/material.dart';

class NoContentWidget extends StatelessWidget {
  const NoContentWidget(this.message, {super.key});

  final String message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}
