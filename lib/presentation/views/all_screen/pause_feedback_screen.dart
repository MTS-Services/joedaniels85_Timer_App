import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joedaniels85_timer_app/presentation/views/all_screen/analytics_screen.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/asset_path.dart';
import '../../../routes/app_route.dart';
import '../../viewmodels/controller/pause_feedback_controller.dart';
import '../../viewmodels/controller/timer_controller.dart';
import '../../widgets/custome_app_bar.dart';

class PauseFeedbackScreen extends StatelessWidget {
  PauseFeedbackScreen({super.key});

  final PauseFeedbackController controller = Get.put(PauseFeedbackController());
  final TimerController timerController = Get.put(TimerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Hi Joe",
        subtitle: "Ready for a screen-free evening?",
        profileImage: AssetPath.profile,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Obx(() {
                if (!controller.isVisible.value) return const SizedBox.shrink();

                return Container(
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 1.r,
                        spreadRadius: 1.r,
                        offset: Offset(1.w, 1.h),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: AppColors.iconBg,
                          ),
                          child: IconButton(
                            onPressed: () {
                              controller.closeFeedback();
                              Get.offAllNamed(AppRoutes.bottomNavBarScreen);
                            },
                            icon: Icon(Icons.close, size: 20.sp),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "How was your Pause?",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Your feedback helps us understand your digital wellness \njourney",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 14.sp),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20.h),
                      _buildFeedbackList(),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeedbackList() {
    return Obx(() {
      return Column(
        children: List.generate(controller.feedbackOptions.length, (index) {
          final option = controller.feedbackOptions[index];
          final isSelected = controller.selectedIndex.value == index;

          return GestureDetector(
            onTap: () {
              // User selects feedback
              controller.selectedIndex.value = index;

              // Navigate to TimerScreen after 200ms
              Future.delayed(const Duration(milliseconds: 200), () {
                Get.offAllNamed(AppRoutes.bottomNavBarScreen);
              });
            },
            child: Container(
              padding: EdgeInsets.all(10.w),
              margin: EdgeInsets.only(bottom: 8.h),
              decoration: BoxDecoration(
                color: isSelected ? Colors.green.shade50 : Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 2.r,
                    offset: Offset(1.w, 1.h),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.iconBg,
                    ),
                    child: Image.asset(
                      option['icon']!,
                      width: 20.w,
                      height: 20.h,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          option['title']!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          option['subtitle']!,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.check_circle,
                    color: isSelected ? Colors.green : Colors.grey,
                    size: 20.sp,
                  ),
                ],
              ),
            ),
          );
        }),
      );
    });
  }
}
