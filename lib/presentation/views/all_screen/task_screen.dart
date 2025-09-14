import 'package:flutter/material.dart';
import 'package:joedaniels85_timer_app/core/constants/asset_path.dart';
import '../../widgets/task_card.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: ListView(
          children: [
           Text(
              "Quick checklist",
              style: Theme.of(context).textTheme.bodyMedium
            ),
            const SizedBox(height: 10),
            ...List.generate(10, (index) {
              return TaskCard(
                title: "Said goodnight to loved ones",
                fontWeight: FontWeight.normal,
                imagePath: AssetPath.chartIcon,
                actions: [
                  ActionIcon(
                    icon: Icons.check_circle_outline_outlined,
                    color: Colors.green,
                    onTap: () => print("Checked!"),
                  ),
                  ActionIcon(
                    icon: Icons.edit,
                    color: Colors.blue,
                    onTap: () => print("Edit tapped!"),
                  ),
                  ActionIcon(
                    icon: Icons.delete,
                    color: Colors.red,
                    onTap: () => print("Delete tapped!"),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
