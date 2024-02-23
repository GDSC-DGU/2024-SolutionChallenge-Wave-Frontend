import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:wave/common/const/colors.dart';

class CountryCategoryButton extends StatelessWidget {
  final String countryName;
  final String category;

  const CountryCategoryButton({Key? key, required this.category, required this.countryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor = Colors.white;
    switch (category) {
      case 'EMERGENCY':
        backgroundColor = EMERGENCY_RED_COLOR;
        break;
      case 'ALERT':
        backgroundColor = ALERT_ORANGE_COLOR;
        break;
      case 'CAUTION':
        backgroundColor = CAUTION_YELLO_COLOR;
        textColor = Colors.black;
        break;
      default:
        backgroundColor = Colors.grey;
    }

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            // 블러 효과를 더 잘 보이게 하기 위해 색상의 불투명도를 조정
            color: backgroundColor.withOpacity(0.9),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(6, 3, 10, 3),
            child: Text(
              countryName,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
