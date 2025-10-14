import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joedaniels85_timer_app/presentation/viewmodels/controller/profile_controller.dart';

class ProfileImageController extends GetxController {
  var imageFile = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();
  final UserProfileController profileController = Get.find();

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      imageFile.value = file;
      await profileController.updateProfile(profilePicFile: file);
      await profileController.fetchProfile(); // refresh after update
    }
  }
}
