import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../viewmodels/controller/profile_controller.dart';
import '../viewmodels/controller/profile_image_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String subtitle;
  final UserProfileController profileController = Get.put(UserProfileController());
  final ProfileImageController imageController = Get.put(ProfileImageController());

  CustomAppBar({super.key, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      surfaceTintColor: Colors.transparent,
      toolbarHeight: 70.h,
      title: Obx(() {
        final file = imageController.imageFile.value;
        final rawProfilePic = profileController.profileList.value?.profilePic;
        final name = profileController.profileList.value?.name ?? "User Name";
        final profilePic = rawProfilePic?.replaceAll("'", "").trim() ?? "";
        ImageProvider? imageProvider;

        if (file != null) {
          imageProvider = FileImage(file);
        } else if (profilePic.isNotEmpty) {
          if (profilePic.startsWith("http")) {
            imageProvider = NetworkImage(profilePic);
          } else {
            final localFile = File(profilePic);
            if (localFile.existsSync()) {
              imageProvider = FileImage(localFile);
            }
          }
        }

        return Row(
          children: [
            // Name & Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    subtitle,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 14.sp,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            // Profile Picture
            Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: CircleAvatar(
                radius: 20.r,
                backgroundColor: Colors.grey.shade300,
                backgroundImage: imageProvider,
                child: imageProvider == null
                    ? Icon(
                  Icons.person,
                  size: 22.r,
                  color: Colors.grey.shade700,
                )
                    : null,
              ),
            ),
          ],
        );
      }),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70.h);
}
