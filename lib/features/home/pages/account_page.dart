import 'package:barber_admin/core/app/images.dart';
import 'package:barber_admin/core/extension/context.dart';
import 'package:barber_admin/core/ui/custom_app_bar.dart';
import 'package:barber_admin/core/ui/simple_button.dart';
import 'package:barber_admin/features/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Account',
        onBackPressed: () {},
        shouldShowBack: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //profile image
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey,
              backgroundImage: AssetImage(Images.userImage),
            ),
            const SizedBox(height: 16),
            //user name
            Text(
              'John Doe',
              style: context.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            //user email
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.email),
                const SizedBox(width: 10),
                Text(
                  'john@gmail.com',
                  style: context.textTheme.bodyLarge,
                ),
              ],
            ),
            const SizedBox(height: 8),
            //user phone number
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.call),
                const SizedBox(width: 10),
                Text(
                  '+966 123 456 789',
                  style: context.textTheme.bodyLarge
                ),
              ],
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.maxFinite,
              child: SimpleButton(
                text: 'Logout',
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInScreen(),
                    ),
                    (route) => false,
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.maxFinite,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colorScheme.error,
                ),
                onPressed: () {},
                child: const Text('Delete Account'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
