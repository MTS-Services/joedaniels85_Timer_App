import 'package:flutter/material.dart';

class ContinueWith extends StatelessWidget {
  const ContinueWith({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(thickness: 1, color: Colors.grey)),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Or continue with",
            style: TextTheme.of(context).bodySmall,
          ),
        ),
        Expanded(child: Divider(thickness: 1, color: Colors.grey)),
      ],
    );
  }
}