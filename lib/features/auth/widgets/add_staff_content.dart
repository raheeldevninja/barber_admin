import 'dart:io';
import 'package:barber_admin/core/extension/context.dart';
import 'package:barber_admin/core/model/staff.dart';
import 'package:barber_admin/core/ui/simple_button.dart';
import 'package:barber_admin/core/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class AddStaffContent extends StatefulWidget {
  const AddStaffContent({
    this.staff,
    super.key,
  });

  final Staff? staff;

  @override
  State<AddStaffContent> createState() => _AddStaffContentState();
}

class _AddStaffContentState extends State<AddStaffContent> {
  final _formKey = GlobalKey<FormState>();

  final _staffNameController = TextEditingController();

  File? _staffImage;

  @override
  void initState() {
    super.initState();
    _initStaff();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 50),
            Text(
              'Add Staff',
              style: context.textTheme.titleMedium,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _staffNameController,
              decoration: const InputDecoration(
                labelText: 'Staff Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Staff Name is empty';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            //image picker
            GestureDetector(
              onTap: _getStaffImage,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: context.colorScheme.outlineVariant,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _staffImage == null
                        ? Icon(
                            Icons.add_a_photo,
                            size: 40,
                            color: context.colorScheme.surface,
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(_staffImage!, fit: BoxFit.cover),
                          ),
                  ),

                  //delete
                  if (_staffImage != null)
                    Positioned(
                      right: -10,
                      top: -10,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _staffImage = null;
                          });
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.colorScheme.error,
                          ),
                          child: Icon(
                            Icons.close,
                            color: context.colorScheme.onError,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            SizedBox(
              width: double.maxFinite,
              child: SimpleButton(
                text: 'Add Staff',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (_staffImage == null) {
                      Utils.showCustomSnackBar(
                          context, 'Please select image', ContentType.failure);

                      return;
                    }

                    Staff staff = Staff(
                      image: _staffImage!,
                      name: _staffNameController.text.trim(),
                    );

                    Navigator.pop(context, staff);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _getStaffImage() async {
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

              _staffImage = File(tempFile.path);

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

              _staffImage = File(tempFile.path);

              setState(() {

              });


            },
          ),
        ],
      ),
    );
  }

  _initStaff() {
    if(widget.staff != null) {
      _staffNameController.text = widget.staff!.name;
      _staffImage = widget.staff!.image;

      setState(() {

      });
    }
  }


  @override
  void dispose() {
    super.dispose();

    _staffNameController.dispose();
    _staffImage = null;
  }
}
