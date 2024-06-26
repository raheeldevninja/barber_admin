import 'dart:io';
import 'package:barber_admin/core/model/staff.dart';
import 'package:flutter/material.dart';

class StaffItem extends StatelessWidget {
  const StaffItem({
    required this.staff,
    required this.onPressed,
    required this.onDismissed,
    super.key,
  });

  final Staff staff;
  final VoidCallback onPressed;
  final VoidCallback onDismissed;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onPressed,
      child: Card(
        elevation: 4,
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: FileImage(File(staff.image.path)),
              ),
              const SizedBox(width: 16),
              Text(
                staff.name.toUpperCase(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
