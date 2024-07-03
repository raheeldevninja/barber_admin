import 'dart:io';

import 'package:barber_admin/core/extension/context.dart';
import 'package:barber_admin/core/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CircleImagePicker extends StatefulWidget {
  const CircleImagePicker({super.key});

  @override
  State<CircleImagePicker> createState() => _CircleImagePickerState();
}

class _CircleImagePickerState extends State<CircleImagePicker> {
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        _pickedImage != null
            ? CircleAvatar(
                radius: 50,
                backgroundImage:
                    _pickedImage != null ? FileImage(_pickedImage!) : null,
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
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.camera_alt,
                color: context.colorScheme.primary,
              ),
            ),
          ),
        ),
      ],
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

              _pickedImage = File(tempFile.path);

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

              _pickedImage = File(tempFile.path);

              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
