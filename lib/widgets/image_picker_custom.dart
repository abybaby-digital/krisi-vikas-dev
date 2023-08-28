import 'package:file_picker/file_picker.dart';

class ImagePickerCustom {
  static var Image;
  static SelectImageFromGalary() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'jpg',
          'JPG',
          'png',
          'PNG',
          'webp',
          'WEBP',
          'jpeg',
          'JPEG'
        ]);

    if (result != null && result.paths.isNotEmpty) {
      List allowedExtensions = [
        'jpg',
        'JPG',
        'png',
        'PNG',
        'webp',
        'WEBP',
        'jpeg',
        'JPEG'
      ];
      PlatformFile file = result.files.first;

      var extentionData = file.extension!.toString();

      if (allowedExtensions.contains(extentionData)) {
        Image = file.path!.toString();
      } else {
        Image = null;
      }
    } else {
      print('No file selected');
      Image = null;
    }
  }
}
