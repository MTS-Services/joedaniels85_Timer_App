import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../../../core/constants/urls.dart';

class ProfileImageController extends GetxController {
  var imageFile = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }


  void removeImage() {
    imageFile.value = null;
  }

  Future<void> uploadProfilePic() async {
    if (imageFile.value == null) {
      Get.snackbar('Error', 'Please select an image first');
      return;
    }

    try {
      var uri = Uri.parse(Urls.userProfile);

      var request = http.MultipartRequest('POST', uri);

      request.files.add(
        await http.MultipartFile.fromPath(
          'profile_pic',
          imageFile.value!.path,
          filename: basename(imageFile.value!.path),
        ),
      );


      request.headers.addAll({
        'Content-Type': '',
        'Authorization': 'Bearer YOUR_TOKEN',
      });

      var response = await request.send();

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Profile picture uploaded successfully!');
        print("Response: ${await response.stream.bytesToString()}");
      } else {
        Get.snackbar('Failed', 'Upload failed: ${response.statusCode}');
        print("Server error: ${response.reasonPhrase}");
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload image: $e');
      print("Error uploading profile picture: $e");
    }
  }
}
