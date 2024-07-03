import 'dart:io';
import 'package:barber_admin/core/extension/context.dart';
import 'package:barber_admin/core/model/working_day.dart';
import 'package:barber_admin/core/ui/app_text_field.dart';
import 'package:barber_admin/core/ui/custom_app_bar.dart';
import 'package:barber_admin/core/ui/simple_button.dart';
import 'package:barber_admin/core/utils/utils.dart';
import 'package:barber_admin/features/auth/add_services_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterBusinessScreen extends StatefulWidget {
  const RegisterBusinessScreen({super.key});

  @override
  State<RegisterBusinessScreen> createState() => _RegisterBusinessScreenState();
}

class _RegisterBusinessScreenState extends State<RegisterBusinessScreen> {
  final _formKey = GlobalKey<FormState>();

  final _businessNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  final _servicesController = TextEditingController();
  final _addressController = TextEditingController();

  List<WorkingDay> _workingDays = [];

  File? _shopImage;

  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();

    _initWeekdays();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add Business Details',
        shouldShowBack: false,
        onBackPressed: () {},
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            InkWell(
              onTap: () {
                _getShopImage();
              },
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: double.maxFinite,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: _shopImage == null
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: context.colorScheme.secondaryContainer,
                        ),
                        child: Icon(
                          Icons.add,
                          size: 60,
                          color: context.colorScheme.onSecondaryContainer,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(
                          _shopImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
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
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              hintText: 'Enter mobile number',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Mobile Number is empty';
                }

                return null;
              },
            ),

            const SizedBox(height: 10),

            Text(
              'Working Days',
              style: context.textTheme.titleSmall,
            ),

            const SizedBox(height: 8),

            //working days
            Wrap(
              spacing: 10,
              runSpacing: 10,
              direction: Axis.horizontal,
              children: _workingDays
                  .map(
                    (day) => InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        setState(() {
                          day.isSelected = !day.isSelected!;
                        });
                      },
                      child: Container(
                        height: 44,
                        width: 100,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: day.isSelected!
                              ? context.colorScheme.tertiary.withOpacity(0.2)
                              : context.colorScheme.onPrimary,
                          border: Border.all(
                            color: day.isSelected!
                                ? context.colorScheme.tertiary
                                : context.colorScheme.outlineVariant,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          day.weekday!,
                          style: TextStyle(
                              color: day.isSelected!
                                  ? context.colorScheme.tertiary
                                  : context.colorScheme.primary),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),

            const SizedBox(height: 10),

            GestureDetector(
              onTap: () {
                _selectStartTime(context);
              },
              child: AbsorbPointer(
                child: /*TextFormField(
                  controller: _startTimeController,
                  decoration: InputDecoration(
                    labelText: 'Start Time',
                    hintText: startTime.format(context),
                  ),
                ),*/
                AppTextField(
                  controller: _startTimeController,
                  hintText: 'Start Time',
                  keyboardType: TextInputType.none,
                  validator: (value){
                    return null;
                  },
                ),


              ),
            ),

            const SizedBox(height: 20),

            GestureDetector(
              onTap: () {
                _selectEndTime(context);
              },
              child: AbsorbPointer(
                child: /*TextFormField(
                  controller: _endTimeController,
                  decoration: InputDecoration(
                    labelText: 'End Time',
                    hintText: endTime.format(context),
                  ),
                ),*/
                AppTextField(
                  controller: _endTimeController,
                  hintText: 'End Time',
                  keyboardType: TextInputType.none,
                  validator: (value){
                    return null;
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

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

            const SizedBox(height: 20),

            SimpleButton(
              text: 'Next',
              onPressed: () {
                if (_formKey.currentState!.validate()) {}

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddServicesScreen(),
                  ),
                );
              },
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

              //XFile? tempFile = await _getImageFromGallery();
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

              //XFile? tempFile = await _getImageFromCamera();
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

  _initWeekdays() {
    _workingDays = [
      WorkingDay(weekday: 'Monday', isSelected: false),
      WorkingDay(weekday: 'Tuesday', isSelected: false),
      WorkingDay(weekday: 'Wednesday', isSelected: false),
      WorkingDay(weekday: 'Thursday', isSelected: false),
      WorkingDay(weekday: 'Friday', isSelected: false),
      WorkingDay(weekday: 'Saturday', isSelected: false),
      WorkingDay(weekday: 'Sunday', isSelected: false),
    ];
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: startTime,
    );
    if (picked != null && picked != startTime) {
      setState(() {
        startTime = picked;
        _startTimeController.text = startTime.format(context);
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: endTime,
    );
    if (picked != null && picked != endTime) {
      setState(() {
        endTime = picked;
        _endTimeController.text = endTime.format(context);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();

    _businessNameController.dispose();
    _phoneNumberController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    _servicesController.dispose();
    _addressController.dispose();

    _shopImage = null;
  }
}
