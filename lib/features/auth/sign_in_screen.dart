import 'package:barber_admin/core/ui/app_text_field.dart';
import 'package:barber_admin/core/ui/custom_app_bar.dart';
import 'package:barber_admin/core/ui/simple_button.dart';
import 'package:barber_admin/features/auth/sign_up_screen.dart';
import 'package:barber_admin/features/auth/widgets/sign_in_sign_up_link.dart';
import 'package:barber_admin/features/home/home_screen.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Sign In',
        shouldShowBack: false,
        onBackPressed: () {},
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
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
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SimpleButton(
              text: 'Sign In',
              onPressed: () {
                if (_formKey.currentState!.validate()) {}

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                      (route) => false,
                );

              },
            ),
            const SizedBox(height: 20),

            SignInSignUpLink(
              label: 'Don\'t have an account? ',
              linkLabel: 'Register Here',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpScreen(),
                  ),
                );
              },
            ),

          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
  }
}
