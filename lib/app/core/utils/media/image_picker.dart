import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerUtil {
  final ImagePicker _imagePicker = ImagePicker();

  Future<(File, String)> getImage({required ImageSource source}) async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    File? file = File(image?.path ?? '');
    final selectedFileName = image?.path.split('/').last ?? '';

    return (file, selectedFileName);
  }

  Future<(List<File?>, List<String>)> getImages(
      {required ImageSource source}) async {
    final List<XFile?> images = await _imagePicker.pickMultiImage();
    List<File?> files = [];
    List<String> fileNames = [];
    if (images.isNotEmpty) {
      for (XFile? file in images) {
        files.add(File(file!.path));
        fileNames.add(file.path.split('/').last);
      }
    }
    return (files, fileNames);
  }
}
