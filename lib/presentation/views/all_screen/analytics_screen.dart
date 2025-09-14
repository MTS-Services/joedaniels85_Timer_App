import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/asset_path.dart';
import '../../widgets/achievement_card .dart';
import '../../widgets/start_card.dart';
import '../../widgets/week_days_selector.dart';
import '../../widgets/weekly_minutes_bar_chart.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Your Progress"),
                const SizedBox(height: 10),
                Text(
                  "Last 7 days",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 10),
                _buildRow(),
                const SizedBox(height: 10),
                const Text("Your Progress"),
                const SizedBox(height: 10),
                WeeklyMinutesBarChart(
                  minutes: const [12, 10, 15, 20, 26, 36, 45],
                  barColor: Colors.teal,
                  backgroundColor: Colors.grey, // or Colors.grey.shade200
                ),
                const SizedBox(height: 10),
                const Text("Your Progress"),
                const SizedBox(height: 10),
                WeekDaysSelector(
                  height: 40,
                  days: const ["Fri", "Wed", "Sat", "Sun", "Tue", "Mon", "Thu"],
                  backgroundColor: Colors.teal,
                  onDaySelected: (day) {
                    debugPrint("Selected Day: $day");
                  },
                ),
                _buildGridView(),
                Text("Achievements"),
                _statusCard(context),
                _statusCard(context),
                _statusCard(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _statusCard(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.statusColor,
          child: Icon(Icons.calendar_month_outlined, color: Colors.white),
        ),
        title: Text(
          "sun",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20),
        ),
        subtitle: Text("75 min", style: Theme.of(context).textTheme.bodySmall),
        trailing: Container(
          height: 30,
          width: 100,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Text(
              "Success",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StartCard(
          vPadding: 0,
          hPadding: 55.0,
          showButton: false,
          centerIcon: AssetPath.analysis,
          size: 60,
          titleSpans: const [
            TextSpan(
              text: "420m",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            TextSpan(text: "\nTotal Time", style: TextStyle(fontSize: 16)),
          ],
          onButtonTap: () {},
        ),
        const SizedBox(width: 10),
        StartCard(
          vPadding: 0,
          hPadding: 55.0,
          showButton: false,
          centerIcon: AssetPath.node,
          size: 60,
          titleSpans: const [
            TextSpan(
              text: "86%",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            TextSpan(text: "\nToday", style: TextStyle(fontSize: 16)),
          ],
          onButtonTap: () {},
        ),
      ],
    );
  }
  Widget _buildGridView() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 12),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.05,
      children: const [
        AchievementCard(
          title: "First Step",
          subtitle: "Complete your first session",
          bgColor: AppColors.targetColor,
          imageIcon: AssetPath.targetIcon,
          isActive: true,
        ),
        AchievementCard(
          title: "3 Day Streak",
          subtitle: "3 consecutive days",
          bgColor: AppColors.targetColor2,
          imageIcon: AssetPath.targetIcon,
        ),
        AchievementCard(
          title: "Weekly Warrior",
          subtitle: "7 day in a row",
          bgColor: AppColors.targetColor3,
          imageIcon: AssetPath.targetIcon,
        ),
        AchievementCard(
          title: "Marathon Master",
          subtitle: "5 Hours in one session",
          bgColor: AppColors.targetColor4,
          imageIcon: AssetPath.targetIcon,
        ),
      ],
    );
  }
}
