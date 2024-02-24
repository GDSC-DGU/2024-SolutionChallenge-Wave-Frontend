import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wave/common/const/colors.dart';
import 'package:wave/user/model/user_model.dart';
import 'package:wave/user/component/show_confirmation_dialog.dart';
import 'package:wave/user/view/badge_congrats_screen.dart';
import 'package:wave/user/view/badge_screen.dart';

import 'my_page_components.dart';

class MyPageUserCard extends StatelessWidget {
  final UserModel user;
  final String amountBadge;
  final String countBadge;

  const MyPageUserCard({
    Key? key,
    required this.user,
    required this.amountBadge,
    required this.countBadge,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: PRIMARY_BLUE_COLOR,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  user.nickname,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              InkWell(
                onTap: () {
                  // BadgeScreen으로 이동
                  if (amountBadge == "NONE" || countBadge == "NONE") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BadgeScreen(),
                      ),
                    );
                  } else if (amountBadge == "NONE" ||
                      countBadge == "FIRST_COUNT_BADGE") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BadgeCongratsScreen(
                              amount: "NONE", count: "1")),
                    );
                  } else if (amountBadge == "NONE" ||
                      countBadge == "SECOND_COUNT_BADGE") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BadgeCongratsScreen(
                              amount: "NONE", count: "5")),
                    );
                  } else if (amountBadge == "NONE" ||
                      countBadge == "THIRD_COUNT_BADGE") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BadgeCongratsScreen(
                              amount: "NONE", count: "10")),
                    );
                  } else if (amountBadge == "NONE" ||
                      countBadge == "FOURTH_COUNT_BADGE") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BadgeCongratsScreen(
                              amount: "NONE", count: "50")),
                    );
                  } else if (amountBadge == "NONE" ||
                      countBadge == "FIFTH_COUNT_BADGE") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BadgeCongratsScreen(
                              amount: "NONE", count: "100")),
                    );
                  } else if (amountBadge == "FIRST_AMOUNT_BADGE" ||
                      countBadge == "FIRST_COUNT_BADGE") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BadgeCongratsScreen(
                              amount: "10", count: "1")),
                    );
                  } else if (amountBadge == "FIRST_AMOUNT_BADGE" ||
                      countBadge == "SECOND_COUNT_BADGE") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BadgeCongratsScreen(
                              amount: "10", count: "5")),
                    );
                  } else if (amountBadge == "FIRST_AMOUNT_BADGE" ||
                      countBadge == "THIRD_COUNT_BADGE") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BadgeCongratsScreen(
                              amount: "10", count: "10")),
                    );
                  } else if (amountBadge == "FIRST_AMOUNT_BADGE" ||
                      countBadge == "FOURTH_COUNT_BADGE") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BadgeCongratsScreen(
                              amount: "10", count: "50")),
                    );
                  } else if (amountBadge == "FIRST_AMOUNT_BADGE" ||
                      countBadge == "FIFTH_COUNT_BADGE") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BadgeCongratsScreen(
                              amount: "10", count: "100")),
                    );
                  } else if (amountBadge == "SECOND_AMOUNT_BADGE" ||
                      countBadge == "FIRST_COUNT_BADGE") {
                    print('level');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BadgeCongratsScreen(
                              amount: "100", count: "1")),
                    );
                  } else if (amountBadge == "SECOND_AMOUNT_BADGE" ||
                      countBadge == "SECOND_COUNT_BADGE") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BadgeCongratsScreen(
                              amount: "100", count: "5")),
                    );
                  } else if (amountBadge == "SECOND_AMOUNT_BADGE" ||
                      countBadge == "THIRD_COUNT_BADGE") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BadgeCongratsScreen(
                              amount: "100", count: "10")),
                    );
                  } else if (amountBadge == "SECOND_AMOUNT_BADGE" ||
                      countBadge == "FOURTH_COUNT_BADGE") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BadgeCongratsScreen(
                              amount: "100", count: "50")),
                    );
                  } else if (amountBadge == "SECOND_AMOUNT_BADGE" ||
                      countBadge == "FIFTH_COUNT_BADGE") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BadgeCongratsScreen(
                              amount: "100", count: "100")),
                    );
                  } else if (amountBadge == "THIRD_AMOUNT_BADGE" ||
                      countBadge == "FIRST_COUNT_BADGE") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BadgeCongratsScreen(
                              amount: "1000", count: "1")),
                    );
                  } else if (amountBadge == "THIRD_AMOUNT_BADGE" ||
                      countBadge == "SECOND_COUNT_BADGE") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BadgeCongratsScreen(
                              amount: "1000", count: "5")),
                    );
                  } else if (amountBadge == "THIRD_AMOUNT_BADGE" ||
                      countBadge == "THIRD_COUNT_BADGE") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BadgeCongratsScreen(
                              amount: "1000", count: "10")),
                    );
                  } else if (amountBadge == "THIRD_AMOUNT_BADGE" ||
                      countBadge == "FOURTH_COUNT_BADGE") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BadgeCongratsScreen(
                              amount: "1000", count: "50")),
                    );
                  } else if (amountBadge == "THIRD_AMOUNT_BADGE" ||
                      countBadge == "FIFTH_COUNT_BADGE") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BadgeCongratsScreen(
                              amount: "1000", count: "100")),
                    );
                  } else {}
                },
                child: Image.asset(
                  'assets/icons/myBadgeButton.png', // SVG 파일의 경로
                  width: 50,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF242424), // 내부 박스 색상 변경
              borderRadius: BorderRadius.circular(15),
            ),
            child: buildInfoSection(user.totalWave, user.donationCountryCnt),
          )
        ],
      ),
    );
  }
}
