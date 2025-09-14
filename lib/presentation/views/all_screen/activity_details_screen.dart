import 'package:flutter/material.dart';
import 'package:joedaniels85_timer_app/core/constants/app_colors.dart';
import 'package:joedaniels85_timer_app/core/constants/asset_path.dart';

class ActivityDetailsScreen extends StatelessWidget {
  const ActivityDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.statusColor,
                child: Image.asset(
                  AssetPath.bookOpen,
                  width: 40,
                  height: 40,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 30),
              Text("Activities"),
              Text(
                "Discover meaningful offline activities",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: 30),
              _statusBar(context),
              SizedBox(height: 25),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Benefits",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  _buildRow(context, "Improves vocabulary"),
                  SizedBox(height: 5),
                  _buildRow(context, "Reduces stress"),
                  SizedBox(height: 5),
                  _buildRow(context, "Enhances focus"),
                  SizedBox(height: 5),
                  _buildRow(context, "Stimulates imagination"),
                  SizedBox(height: 10),
                  Text(
                    "Benefits",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  _chooseStatus(context , "1" , "Choose a book you've been wanting to read"),
                  SizedBox(height: 5),
                  _chooseStatus(context , "2" , "Find a comfortable, well-lit spot"),
                  SizedBox(height: 5),
                  _chooseStatus(context , "3" , "Put your phone In another room"),
                  SizedBox(height: 5),
                  _chooseStatus(context , "4" , "Read for at least 20 minutes"),
                  SizedBox(height: 5),
                  _chooseStatus(context , "5" , "Take notes of interesting ideas"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chooseStatus(BuildContext context , String a , String text) {
    return Row(
      children: [
        CircleAvatar(
          radius: 10,
          backgroundColor: AppColors.statusColor,
          child: Text(
            "$a",
            style: Theme.of(
              context,
            ).textTheme.bodySmall!.copyWith(fontSize: 15, color: Colors.white),
          ),
        ),
        SizedBox(width: 10 ,),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildRow(BuildContext context, String text) {
    return Row(
      children: [
        CircleAvatar(radius: 5, backgroundColor: Colors.green),
        SizedBox(width: 5),
        Text(text, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Widget _statusBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Duration",
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(fontSize: 14),
              ),
              Text(
                "30-60 min",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Category",
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(fontSize: 14),
              ),
              Text(
                "Learning",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Difficulty",
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(fontSize: 14),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                decoration: BoxDecoration(
                  color: Color(0xffF6F6F6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  "Easy",
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(fontSize: 15),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
