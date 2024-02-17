import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wave/common/const/colors.dart';

class ForwardDetailButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPressed;
  final double? width; // 너비를 옵셔널로 받음
  final bool? isSearch; // 검색 버튼 여부를 결정하는 플래그

  const ForwardDetailButton({
    Key? key,
    required this.buttonName,
    required this.onPressed,
    this.width, // 너비를 옵셔널로 받음
    this.isSearch = false, // 기본값은 false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 너비가 지정되지 않았을 때의 기본값 설정
    final buttonWidth = width ?? 300.0; // 기본 너비를 300.0으로 설정

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: BUTTON_BACKGROUND_COLOR, // 버튼 배경색 사용
        minimumSize: Size(buttonWidth, 54), // 동적으로 너비 설정
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            buttonName,
            style: TextStyle(
              color: BUTTON_TEXT_COLOR, // 버튼 텍스트 색상 사용
              fontWeight: FontWeight.w600,
              fontSize: isSearch == true ? 16 : 20, // isSearch가 true이면 폰트 크기를 14로 설정
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: SvgPicture.asset(
              'assets/icons/rightArrow.svg', // SVG 아이콘 사용
              height: isSearch == true ? 16 : 20, // isSearch가 true이면 SVG 아이콘 크기를 14로 설정
            ),
          ),
        ],
      ),
    );
  }
}
