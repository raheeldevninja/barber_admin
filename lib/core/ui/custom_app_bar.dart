import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    required this.title,
    required this.onBackPressed,
    this.shouldShowBack = true,
    super.key});

  final String title;
  final bool shouldShowBack;
  final VoidCallback onBackPressed;

  @override
  Widget build(BuildContext context) {


    return AppBar(
      backgroundColor: Colors.black,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      leadingWidth: shouldShowBack ? 40 : 0,
      leading: shouldShowBack ? IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: onBackPressed,
      ) : const SizedBox(),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);

}
