import 'dart:io';

import 'package:image_picker/image_picker.dart';

class MainServices {
  static Future<File?> getCameraImageUsingImagePicker(
      ImageSource source) async {
    var pickedImage = await ImagePicker().pickImage(
      source: source,
      imageQuality: 15,
    );
    if (pickedImage != null) {
      return File(pickedImage.path);
    } else {
      return null;
    }
  }

  static Future<File?> getImageUsingImagePicker(ImageSource source) async {
    var pickedImage = await ImagePicker().pickMedia(
      imageQuality: 15,
    );
    if (pickedImage != null) {
      return File(pickedImage.path);
    } else {
      return null;
    }
  }


}
