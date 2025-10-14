import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../viewmodels/controller/profile_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String subtitle;
  final UserProfileController controller = Get.put(UserProfileController());

  CustomAppBar({super.key, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      surfaceTintColor: Colors.transparent,
      toolbarHeight: 70.h,
      title: Obx(
        () => Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.profileList.value != null &&
                            controller.profileList.value!.name.isNotEmpty
                        ? controller.profileList.value!.name
                        : "User Name",
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
              child: Obx(() {
                final imageUrl = controller.profileList.value?.profilePic ?? "";
                return CircleAvatar(
                  radius: 20.r,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: imageUrl.isNotEmpty
                      ? NetworkImage(imageUrl)
                      : null,
                  child: imageUrl.isEmpty
                      ? Icon(
                          Icons.person,
                          size: 22.r,
                          color: Colors.grey.shade700,
                        )
                      : null,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70.h);
}
