import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

Future pickImageFromGallery() async {
  ImageSource source = ImageSource.gallery;
  try {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

    //Spara bilden permanent (funkar inte av någon anledning, ska kika på det)
    // final imagePermanent = await saveImagePermanently(image.path);

    return File(image.path);
  } on PlatformException catch (e) {}
}

Future pickImageFromCamera() async {
  ImageSource source = ImageSource.camera;
  try {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

    //Spara bilden permanent (funkar inte av någon anledning, ska kika på det)
    // final imagePermanent = await saveImagePermanently(image.path);

    return File(image.path);
  } on PlatformException catch (e) {}
}
