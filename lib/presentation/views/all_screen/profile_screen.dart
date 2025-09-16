import 'package:flutter/material.dart';
import 'package:joedaniels85_timer_app/core/constants/asset_path.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: Image.asset(
                      AssetPath.profilePhoto,
                      width: 120,
                      height: 120,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text("Activities"),
                  Text(
                    "Member since Jan 2024",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 25),
                  _statusProfile(context),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              "Recent Achievements",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10,),
            _buildCard(context,"First Step" , "Completed your first session"),
            _buildCard(context,"First Step" , "Completed your first session"),
            _buildCard(context,"First Step" , "Completed your first session"),
            SizedBox(height: 50,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  side: const BorderSide(color: Colors.black, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {

                },
                icon: Icon(Icons.login , size: 24,),
                label: const Text("Log Out"),
              ),
            ),
          ],
        ),
      ),
    );
  }
Widget _buildCard(BuildContext context , String text , String subText ) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        leading: CircleAvatar(child: Image.asset(AssetPath.wineIcon)),
        title: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subText,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
  Widget _statusProfile(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "42",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontSize: 18),
              ),
              Text(
                "Total Sessions",
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(fontSize: 12),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "28h",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontSize: 18),
              ),
              Text(
                "Screen \nfree time",
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "3",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontSize: 18),
              ),
              Text(
                "Current Streak",
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(fontSize: 12),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "3",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontSize: 18),
              ),
              Text(
                "Longest Streak",
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
