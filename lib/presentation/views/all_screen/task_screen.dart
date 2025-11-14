import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:joedaniels85_timer_app/core/constants/asset_path.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Add this import

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late TextEditingController controller;
  late List<Map<String, dynamic>> tasks;
  
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    tasks = [
      {
        "title": "Say goodnight to your loved ones",
        "icon": Icons.favorite,
        "color": Colors.pink,
        "done": false,
        "key": "task_0", // Add unique keys for SharedPreferences
      },
      {
        "title": "Write in your journal",
        "icon": Icons.book,
        "color": Colors.red,
        "done": false,
        "key": "task_1",
      },
      {
        "title": "Check plans for tomorrow",
        "icon": Icons.event_note,
        "color": Colors.blue,
        "done": false,
        "key": "task_2",
      },
      {
        "title": "Stretch for 1 minute",
        "icon": Icons.accessibility,
        "color": Colors.orange,
        "done": false,
        "key": "task_3",
      },
    ];
    _loadTasks(); // Load saved tasks when the screen initializes
  }

  // Load tasks from SharedPreferences
  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    for (var task in tasks) {
      final savedTitle = prefs.getString(task["key"] as String);
      if (savedTitle != null) {
        setState(() {
          task["title"] = savedTitle;
        });
      }
    }
  }

  // Save a task title to SharedPreferences
  Future<void> _saveTask(String key, String title) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, title);
  }

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
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.black54,
                  fontSize: 14.sp,
                ),
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
                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      final isDone = task["done"] as bool;

                      return _TaskItem(
                        title: task["title"] as String,
                        icon: task["icon"] as IconData,
                        color: task["color"] as Color,
                        done: isDone,
                        controller: controller,
                        editOnPressed: () => setState(() {
                          final newTitle = controller.text.trim();
                          task['title'] = newTitle;
                          _saveTask(task["key"] as String, newTitle); // Save to SharedPreferences
                          Get.back();
                        }),
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
                    backgroundColor: allDone
                        ? Colors.teal
                        : Colors.teal.shade200,
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
  final VoidCallback onTap, editOnPressed;
  final TextEditingController controller;

  const _TaskItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.done,
    required this.onTap,
    required this.controller,
    required this.editOnPressed,
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
            Icon(
              done ? Icons.check_circle : Icons.radio_button_unchecked,
              color: done ? Colors.green : Colors.grey.shade300,
              size: 20.sp,
            ),
            SizedBox(width: 5.w),
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
                  decoration: done ? TextDecoration.lineThrough : null,
                  color: done ? Colors.black45 : Colors.black,
                ),
              ),
            ),
            SizedBox(width: 5.w),
            InkWell(
              onTap: () {
                controller.text = title; // Pre-fill with current title
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Edit Checklist'),
                    content: TextFormField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: 'Write a Checklist',
                      ),
                    ),
                    actions: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          onPressed: editOnPressed,
                          child: Text(
                            "Save",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Image.asset(
                AssetPath.pencileIcon,
                width: 20.w,
                height: 20.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}