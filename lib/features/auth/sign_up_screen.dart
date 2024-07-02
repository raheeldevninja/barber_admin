import 'dart:io';
import 'package:barber_admin/core/ui/app_text_field.dart';
import 'package:barber_admin/core/ui/custom_app_bar.dart';
import 'package:barber_admin/core/ui/simple_button.dart';
import 'package:barber_admin/core/utils/utils.dart';
import 'package:barber_admin/features/auth/register_business_screen.dart';
import 'package:barber_admin/features/auth/widgets/sign_in_sign_up_link.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final _ownerNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  File? _ownerImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Sign Up',
        shouldShowBack: true,
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            //image picker
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  _ownerImage != null
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage: _ownerImage != null
                              ? FileImage(_ownerImage!)
                              : null,
                        )
                      : const CircleAvatar(
                          radius: 50,
                          child: Icon(
                            Icons.image,
                            size: 40,
                          ),
                        ),

                  //image picker
                  Positioned(
                    child: GestureDetector(
                      onTap: _getOwnerImage,
                      child: const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            AppTextField(
              controller: _ownerNameController,
              keyboardType: TextInputType.text,
              hintText: 'Owner Name',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Owner Name is empty';
                }
                return null;
              },
            ),

            const SizedBox(height: 10),

            AppTextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              hintText: 'Email',
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                      .hasMatch(value)) {
                    return 'Invalid Email';
                  }
                } else if (value!.isEmpty) {
                  return 'Email field empty';
                }

                return null;
              },
            ),

            const SizedBox(height: 10),

            AppTextField(
              controller: _passwordController,
              keyboardType: TextInputType.text,
              hintText: 'Password',
              isPassword: true,
              obscureText: _obscureText,
              visibilityCallback: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password field empty';
                } else if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }

                return null;
              },
            ),

            const SizedBox(height: 20),
            SimpleButton(
              text: 'Sign Up',
              onPressed: () {
                if (_formKey.currentState!.validate()) {}

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterBusinessScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            SignInSignUpLink(
              label: 'Already have an account? ',
              linkLabel: 'Login Here',
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future _getOwnerImage() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () async {
              // close the options modal
              Navigator.of(context).pop();

              // get image from gallery
              XFile? tempFile = await Utils.getImageFromGallery();

              if (tempFile == null) {
                return;
              }

              _ownerImage = File(tempFile.path);

              setState(() {});
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () async {
              // close the options modal
              Navigator.of(context).pop();

              // get image from camera
              XFile? tempFile = await Utils.getImageFromCamera();

              if (tempFile == null) {
                return;
              }

              _ownerImage = File(tempFile.path);

              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _ownerNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}
