import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class StartCard extends StatelessWidget {
  final List<TextSpan> titleSpans;
  final String? circleImage;
  final String? centerIcon;
  final IconData? buttonIcon;
  final String buttonText;
  final VoidCallback? onButtonTap;
  final Color buttonColor;
  final double buttonWidth;
  final bool showButton;
  final double size;
  final double vPadding;
  final double hPadding;
  final Color? bgColor;

  const StartCard({
    super.key,
    required this.titleSpans,
    this.circleImage,
    this.centerIcon,
    this.buttonIcon,
    this.buttonText = "Next",
    this.onButtonTap,
    this.buttonColor = AppColors.primary,
    this.buttonWidth = 120,
    this.showButton = true,
    this.size = 30,
    this.vPadding = 15,
    this.hPadding = 15,
    this.bgColor = Colors.white
  });

  @override
  Widget build(BuildContext context) {
    final Color defaultColor =
    circleImage != null ? Colors.white : Colors.black;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (circleImage != null) Image.asset(circleImage!),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    if (centerIcon != null)
                      Image.asset(centerIcon!, width: size),
                    const SizedBox(height: 10),
                    Text.rich(
                      TextSpan(
                        children: [
                          ...titleSpans,
                          const TextSpan(text: "\n"),
                        ],
                      ),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: defaultColor,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          if (showButton)
            InkWell(
              onTap: onButtonTap,
              borderRadius: BorderRadius.circular(50),
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: buttonWidth,
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (buttonIcon != null) ...[
                        Icon(buttonIcon, color: Colors.white),
                        const SizedBox(width: 5),
                      ],
                      Text(
                        buttonText,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
