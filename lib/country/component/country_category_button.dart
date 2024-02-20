import 'package:flutter/material.dart';
import 'package:wave/common/const/colors.dart';

class CountryCategoryButton extends StatelessWidget {
  final String countryName;
  final String category;

  const CountryCategoryButton({Key? key, required this.category, required this.countryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    switch (category) {
      case 'EMERGENCY':
        backgroundColor = EMERGENCY_RED_COLOR;
        break;
      case 'ALERT':
        backgroundColor = ALERT_ORANGE_COLOR;
        break;
      case 'CAUTION':
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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6,3, 10, 3),
        child: Text(
          countryName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
