import 'package:flutter/material.dart';
import 'package:wave/common/const/colors.dart';

class CategoryButton extends StatelessWidget {
  final String category;

  const CategoryButton({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    switch (category) {
      case 'Emergency':
        backgroundColor = EMERGENCY_RED_COLOR;
        break;
      case 'Alert':
        backgroundColor = ALERT_ORANGE_COLOR;
        break;
      case 'Caution':
        backgroundColor = CAUTION_YELLO_COLOR;
        break;
      default:
        backgroundColor = Colors.grey; // Default color if category doesn't match
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Text(
        category,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}