import 'dart:io';

import 'package:barber_admin/core/app/images.dart';
import 'package:barber_admin/core/extension/context.dart';
import 'package:barber_admin/core/ui/app_text_field.dart';
import 'package:barber_admin/core/ui/circle_image_picker.dart';
import 'package:barber_admin/core/ui/custom_app_bar.dart';
import 'package:barber_admin/core/ui/simple_button.dart';
import 'package:barber_admin/core/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BusinessDetailsScreen extends StatefulWidget {
  const BusinessDetailsScreen({super.key});

  @override
  State<BusinessDetailsScreen> createState() => _BusinessDetailsScreenState();
}

class _BusinessDetailsScreenState extends State<BusinessDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  final _businessNameController = TextEditingController();
  final _ownerNameController = TextEditingController();

  File? _shopImage;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Shop Details',
        onBackPressed: () {
          Navigator.pop(context);
        },
        shouldShowBack: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            //shop image
            Stack(
              children: [
                Container(
                    width: double.maxFinite,
                    height: 160,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: _shopImage == null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              Images.barberShopImage,
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.file(
                              _shopImage!,
                              fit: BoxFit.cover,
                            ),
                          )),
                //edit button
                Positioned(
                  right: 16,
                  top: 16,
                  child: InkWell(
                    onTap: () {
                      _getShopImage();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.edit,
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //owner image
                  const Center(
                    child: CircleImagePicker(),
                  ),

                  const SizedBox(height: 20),

                  AppTextField(
                    controller: _businessNameController,
                    keyboardType: TextInputType.text,
                    hintText: 'Business Name',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Business Name is empty';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 10),

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
          ],
        ),
      ),
    );
  }

  Future _getShopImage() async {
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

              _shopImage = File(tempFile.path);

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

              _shopImage = File(tempFile.path);

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
    _businessNameController.dispose();
  }
}
