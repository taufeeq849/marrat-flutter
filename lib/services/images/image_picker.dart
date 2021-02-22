import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerService {
  final _imagePicker = ImagePicker();

  PickedFile image;
  pickImage() async {
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted) {
      image = await _imagePicker.getImage(source: ImageSource.gallery);
      if (image != null) {
      var file = File(image.path);
        return file;
      } else {
        return "No Image Recieved";
      }
    } else {
      return "Permission Not Granted";
    }
  }
}
