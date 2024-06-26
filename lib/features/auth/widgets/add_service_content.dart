import 'dart:io';

import 'package:barber_admin/core/model/barber_service.dart';
import 'package:barber_admin/core/ui/simple_button.dart';
import 'package:barber_admin/core/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class AddServiceContent extends StatefulWidget {
  const AddServiceContent({
    this.service,
    super.key,
  });

  final BarberService? service;

  @override
  State<AddServiceContent> createState() => _AddServiceContentState();
}

class _AddServiceContentState extends State<AddServiceContent> {
  final _formKey = GlobalKey<FormState>();

  final _serviceNameController = TextEditingController();
  final _servicePriceController = TextEditingController();
  final _serviceDurationController = TextEditingController();

  File? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    _initService();
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
              'Add Service',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _serviceNameController,
              decoration: const InputDecoration(
                labelText: 'Service Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Service Name is empty';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _servicePriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Service Price',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Service Price is empty';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),
            TextFormField(
              controller: _serviceDurationController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Service Duration',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Service Duration is empty';
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
                text: 'Add Service',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (_image == null) {
                      Utils.showCustomSnackBar(
                          context, 'Please select image', ContentType.failure);

                      return;
                    }

                    BarberService service = BarberService(
                      image: _image?.path,
                      serviceName: _serviceNameController.text.trim(),
                      price: double.parse(_servicePriceController.text),
                      duration: int.parse(_serviceDurationController.text),
                    );

                    Navigator.pop(context, service);
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

  _initService() {

    if (widget.service != null) {
      _serviceNameController.text = widget.service!.serviceName!;
      _servicePriceController.text = widget.service!.price.toString();
      _serviceDurationController.text = widget.service!.duration.toString();
      _image = File(widget.service!.image!);
    }
  }

  @override
  void dispose() {
    super.dispose();

    _serviceNameController.dispose();
    _servicePriceController.dispose();
    _serviceDurationController.dispose();
    _image = null;
  }
}
