import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_route.dart';
import '../../widgets/activity_card.dart';
class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Activities", style: Theme.of(context).textTheme.bodyMedium),
              Text(
                "Discover meaningful offline activities",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Get.toNamed(AppRoutes.activityDetailsScreen);
                      },
                      child: ActivityCard(
                        title: "Reading",
                        description: "Dive into a good book and expand your mind",
                        duration: "10-30 min",
                        level: "Medium",
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
