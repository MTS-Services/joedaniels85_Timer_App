import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joedaniels85_timer_app/presentation/viewmodels/controller/update_profile_controler.dart';


class ProfileImageController extends GetxController {
  var imageFile = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();
  final UpdateProfileController profileController = Get.put(UpdateProfileController());

  Future<void> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        File file = File(pickedFile.path);

        if (!file.existsSync()) return;

        imageFile.value = file;
        if (profileController.profile.value != null) {
          await profileController.updateProfile(
            updatedProfile: profileController.profile.value!,
            profilePicFile: file,
          );
        }
      }
    } catch (e) {
      print("⚠️ Error picking/uploading image: $e");
    }
  }

}
