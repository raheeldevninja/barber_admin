import 'dart:io';
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

  File? _image;
  final picker = ImagePicker();

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
            const Text(
              'Add Staff',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _staffNameController,
              decoration: const InputDecoration(
                labelText: 'Staff Name',
                border: OutlineInputBorder(),
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
              onTap: _showImagePickerOptions,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _image == null
                        ? const Icon(
                            Icons.add_a_photo,
                            size: 40,
                            color: Colors.grey,
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(_image!),
                          ),
                  ),

                  //delete
                  if (_image != null)
                    Positioned(
                      right: -10,
                      top: -10,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _image = null;
                          });
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
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
                    if (_image == null) {
                      Utils.showCustomSnackBar(
                          context, 'Please select image', ContentType.failure);

                      return;
                    }

                    Staff staff = Staff(
                      image: _image!,
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

  Future _getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future _getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future _showImagePickerOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              _getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              _getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }

  _initStaff() {
    if(widget.staff != null) {
      _staffNameController.text = widget.staff!.name;
      _image = widget.staff!.image;

      setState(() {

      });
    }
  }


  @override
  void dispose() {
    super.dispose();

    _staffNameController.dispose();
    _image = null;
  }
}
