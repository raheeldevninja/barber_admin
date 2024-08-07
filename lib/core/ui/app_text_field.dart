import 'package:barber_admin/core/extension/context.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.controller,
    required this.keyboardType,
    required this.validator,
    this.hintText,
    this.isPassword = false,
    this.isPhone = false,
    this.isSearch = false,
    this.obscureText = false,
    this.visibilityCallback,
    this.countryPickerCallback,
    this.maxLines = 1,
    this.isReadOnly = false,
    super.key,
  });

  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? hintText;

  final bool isPassword;
  final bool isPhone;
  final bool isSearch;
  final bool? obscureText;
  final bool isReadOnly;

  final String? Function(String?)? validator;
  final VoidCallback? visibilityCallback;
  final VoidCallback? countryPickerCallback;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    Widget? suffixIcon;

    if (isPassword) {
      suffixIcon = IconButton(
        onPressed: visibilityCallback,
        icon: Icon(
          obscureText! ? Icons.visibility : Icons.visibility_off,
          color: context.colorScheme.surface,
        ),
      );
    } else if (isSearch) {
      suffixIcon = IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.search,
          color: context.colorScheme.surface,
        ),
      );
    } else {
      suffixIcon = null;
    }

    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,
      readOnly: isReadOnly,
      decoration: InputDecoration(
        filled: true,
        fillColor: context.colorScheme.secondary,
        contentPadding: const EdgeInsets.all(12.0),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: context.colorScheme.outline, width: 1.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: context.colorScheme.outline, width: 1.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        prefixIcon: isPhone
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: countryPickerCallback,
                    child: Text(
                      '+966',
                      style: TextStyle(color: context.colorScheme.surface),
                    ),
                  ),
                  Container(
                    height: 20,
                    width: 1,
                    color: context.colorScheme.surface,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                ],
              )
            : null,
        suffixIcon: suffixIcon,
      ),
      validator: validator,
    );
  }
}
