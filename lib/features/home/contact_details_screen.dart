import 'package:barber_admin/core/ui/app_text_field.dart';
import 'package:barber_admin/core/ui/custom_app_bar.dart';
import 'package:barber_admin/core/ui/simple_button.dart';
import 'package:flutter/material.dart';


class ContactDetailsScreen extends StatefulWidget {
  const ContactDetailsScreen({super.key});

  @override
  State<ContactDetailsScreen> createState() => _ContactDetailsScreenState();
}

class _ContactDetailsScreenState extends State<ContactDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Contact Details',
        onBackPressed: () {
          Navigator.pop(context);
        },
        shouldShowBack: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [

            const SizedBox(height: 30),

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
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              hintText: 'Mobile number',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Mobile Number is empty';
                }

                return null;
              },
            ),

            const SizedBox(height: 10),

            AppTextField(
              controller: _addressController,
              keyboardType: TextInputType.text,
              hintText: 'Address',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Address is empty';
                }
                return null;
              },
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.maxFinite,
              child: SimpleButton(
                text: 'Update',
                onPressed: () {},
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

    _emailController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
  }
}
