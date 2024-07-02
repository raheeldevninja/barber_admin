import 'dart:io';

import 'package:barber_admin/core/app/images.dart';
import 'package:barber_admin/core/ui/app_text_field.dart';
import 'package:barber_admin/core/ui/custom_app_bar.dart';
import 'package:barber_admin/core/ui/simple_button.dart';
import 'package:barber_admin/core/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ShopDetailsScreen extends StatefulWidget {
  const ShopDetailsScreen({super.key});

  @override
  State<ShopDetailsScreen> createState() => _ShopDetailsScreenState();
}

class _ShopDetailsScreenState extends State<ShopDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  final _businessNameController = TextEditingController();
  final _ownerNameController = TextEditingController();

  File? _ownerImage;
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

            Stack(
              children: [
                Container(
                  width: double.maxFinite,
                  height: 160,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: _shopImage == null ? ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      Images.barberShopImage,
                      fit: BoxFit.cover,
                    ),
                  ) : ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      _shopImage!,
                      fit: BoxFit.cover,
                    ),
                  )
                ),
                //edit button
                Positioned(
                  right: 16,
                  top: 16,
                  child: InkWell(
                    onTap: () {
                      _getShopImage();
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.edit,
                        color: Colors.black,
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

                  //image picker
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        _ownerImage != null
                            ? CircleAvatar(
                          radius: 50,
                          backgroundImage:
                          _ownerImage != null ? FileImage(_ownerImage!) : null,
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
                            child: InkWell(
                              onTap: () {
                                _getOwnerImage();
                              },
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
                        ),
                      ],
                    ),
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

              if(tempFile == null) {
                return;
              }

              _ownerImage = File(tempFile.path);

              setState(() {

              });

            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () async {
              // close the options modal
              Navigator.of(context).pop();

              // get image from camera
              XFile? tempFile = await Utils.getImageFromCamera();

              if(tempFile == null) {
                return;
              }

              _ownerImage = File(tempFile.path);

              setState(() {

              });

            },
          ),
        ],
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

              //XFile? tempFile = await _getImageFromGallery();
              XFile? tempFile = await Utils.getImageFromGallery();

              if(tempFile == null) {
                return;
              }

              _shopImage = File(tempFile.path);

              setState(() {

              });

            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () async {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera

              //XFile? tempFile = await _getImageFromCamera();
              XFile? tempFile = await Utils.getImageFromCamera();

              if(tempFile == null) {
                return;
              }

              _shopImage = File(tempFile.path);

              setState(() {

              });

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
