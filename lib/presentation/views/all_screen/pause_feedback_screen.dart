import 'package:flutter/material.dart';
import 'package:joedaniels85_timer_app/core/constants/app_colors.dart';
import '../../../core/constants/asset_path.dart';
import '../../widgets/custome_app_bar.dart';
import '../../widgets/task_card.dart';
class PauseFeedbackScreen extends StatelessWidget {
  const PauseFeedbackScreen({super.key});
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 1,
                          spreadRadius: 1,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.iconBg
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.close),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "How was your Pause?",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          "Your feedback helps us understand your digital wellness \njourney",
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall!.copyWith(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                       SizedBox(
                         height: 300,
                         child: ListView.builder(
                           itemCount: 3,
                           padding: EdgeInsets.symmetric(vertical: 10),
                           physics: NeverScrollableScrollPhysics(),
                           shrinkWrap: true,
                           itemBuilder: (context, index) {
                           return TaskCard(
                             cardEle: 2,
                             title: "Great",
                             size: 20,
                             subTitle:"That pause felt refreshing!",
                             fontWeight: FontWeight.normal,
                             imagePath: AssetPath.starIcon,
                             iconColor: Colors.orange,
                             leadingBgColor: AppColors.iconBg,
                             actions: [
                               ActionIcon(
                                 icon: Icons.check_circle_outline_outlined,
                                 color: Colors.grey,
                                 onTap: () {
                                   print("Checked!");
                                 },
                               ),
                             ],
                           );
                         },),
                       )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
