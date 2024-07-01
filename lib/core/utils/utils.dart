import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class Utils {

  static final _picker = ImagePicker();

  static void showCustomSnackBar(
      BuildContext context, String message, ContentType contentType) {
    final snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'SaveInsta',
        message: message,
        contentType: contentType,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }


  static Future<XFile?> getImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    return pickedFile;
  }

  static Future<XFile?> getImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    return pickedFile;
  }

}