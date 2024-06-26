import 'package:barber_admin/core/app/images.dart';
import 'package:barber_admin/core/ui/custom_app_bar.dart';
import 'package:barber_admin/core/ui/simple_button.dart';
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
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey,
              backgroundImage: AssetImage(Images.userImage),
            ),
            const SizedBox(height: 16),
            //user name
            Text(
              'John Doe',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            //user email
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.email),
                const SizedBox(width: 10),
                Text(
                  'john@gmail.com',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            //user phone number
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.call),
                const SizedBox(width: 10),
                Text(
                  '+966 123 456 789',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.maxFinite,
              child: SimpleButton(
                text: 'Logout',
                onPressed: () {},
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.maxFinite,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
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
