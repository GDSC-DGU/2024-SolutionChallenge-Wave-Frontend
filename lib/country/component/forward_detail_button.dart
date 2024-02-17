import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wave/common/const/colors.dart';

class ForwardDetailButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPressed;
  final int? width;

  const ForwardDetailButton({
    Key? key,
    required this.buttonName,
    required this.onPressed,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: BUTTON_BACKGROUND_COLOR, // Use your button background color
        minimumSize: Size(300, 54),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            buttonName,
            style: const TextStyle(
              color: BUTTON_TEXT_COLOR, // Use your button text color
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: SvgPicture.asset(
              'assets/icons/rightArrow.svg',
            ),
          ),
        ],
      ),
    );
  }
}
