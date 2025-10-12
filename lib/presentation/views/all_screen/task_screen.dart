import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final List<Map<String, dynamic>> tasks = [
    {
      "title": "Say goodnight to your loved ones",
      "icon": Icons.favorite,
      "color": Colors.pink,
      "done": false,
    },
    {
      "title": "Write in your journal",
      "icon": Icons.book,
      "color": Colors.red,
      "done": false,
    },
    {
      "title": "Check plans for tomorrow",
      "icon": Icons.event_note,
      "color": Colors.blue,
      "done": true,
    },
    {
      "title": "Stretch for 1 minute",
      "icon": Icons.accessibility,
      "color": Colors.orange,
      "done": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final allDone = tasks.every((t) => t["done"] == true);

    return Scaffold(
      backgroundColor: const Color(0xfff9f9fb),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              SizedBox(height: 40.h),
              Text(
                "Pre-Pause Checklist",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "A few mindful moments before your digital pause begins",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black54, fontSize: 14.sp),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.h),

              // ✅ Card container
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 8,
                        spreadRadius: 1,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: ListView.separated(
                    itemCount: tasks.length,
                    separatorBuilder: (_, __) =>
                        SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      final isDone = task["done"] as bool;

                      return _TaskItem(
                        title: task["title"] as String,
                        icon: task["icon"] as IconData,
                        color: task["color"] as Color,
                        done: isDone,
                        onTap: () {
                          setState(() {
                            tasks[index]["done"] = !isDone;
                          });
                        },
                      );
                    },
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    allDone ? Colors.teal : Colors.teal.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: allDone
                      ? () {
                    Get.offNamed("/bottomNavBarScreen");
                  }
                      : null,
                  child: Text(
                    "Next",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TaskItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final bool done;
  final VoidCallback onTap;

  const _TaskItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.done,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: done ? Colors.green.shade50 : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 4,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, color: color, size: 20.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  decoration:
                  done ? TextDecoration.lineThrough : null,
                  color: done ? Colors.black45 : Colors.black,
                ),
              ),
            ),
            Icon(
              done ? Icons.check_circle : Icons.radio_button_unchecked,
              color: done ? Colors.green : Colors.grey.shade300,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
