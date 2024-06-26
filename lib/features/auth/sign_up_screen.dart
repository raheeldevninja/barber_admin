import 'package:barber_admin/core/ui/app_text_field.dart';
import 'package:barber_admin/core/ui/custom_app_bar.dart';
import 'package:barber_admin/core/ui/simple_button.dart';
import 'package:barber_admin/features/auth/register_business_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Sign Up',
        shouldShowBack: false,
        onBackPressed: () {},
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 80),
          children: [

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
                  if (!RegExp(
                      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                      .hasMatch(value)) {
                    return 'Invalid Email';
                  }
                }
                else if(value!.isEmpty) {
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
                if (_formKey.currentState!.validate()) {

                }


                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterBusinessScreen(),
                  ),
                );
              },
            ),

            const SizedBox(
              height: 16,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Already have an account? ',
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: 'Sign In',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pop(context);
                      },
                  ),
                ],
              ),
            ),


          ],
        ),
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
