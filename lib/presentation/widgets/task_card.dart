import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class ActionIcon {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;


  ActionIcon({
    required this.icon,
    required this.color,
    required this.onTap,
  });
}

class TaskCard extends StatelessWidget {
  final String title;
  final String? imagePath;
  final IconData? leadingIcon;
  final Color leadingBgColor;
  final List<ActionIcon>? actions;
  final String subTitle ;
  final double size;
  final FontWeight? fontWeight;
  final double cardEle ;
  final Color iconColor ;
  const TaskCard({
    super.key,
    required this.title,
    this.imagePath,
    this.leadingIcon,
    this.leadingBgColor = AppColors.primary,
    this.actions,
    this.subTitle = "",
    this.size = 15,
    this.fontWeight = FontWeight.bold,
    this.cardEle = 0,
    this.iconColor = Colors.white
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: cardEle ,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: ListTile(
          leading: (imagePath != null || leadingIcon != null)
              ? CircleAvatar(
            backgroundColor: leadingBgColor,
            child: imagePath != null
                ? Image.asset(
              imagePath!,
              height: 24,
              width: 24,
              color: iconColor,
            )
                : Icon(
              leadingIcon,
              color: iconColor
            ),
          )
              : null,
          title: Text(title , style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: size,
            fontWeight: fontWeight
          )),
          subtitle: Text(subTitle , style: Theme.of(context).textTheme.bodySmall),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: actions != null
                ? actions!
                .map((action) => GestureDetector(
              onTap: action.onTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Icon(action.icon, color: action.color),
              ),
            ))
                .toList()
                : [],
          ),
        ),
      ),
    );
  }
}
