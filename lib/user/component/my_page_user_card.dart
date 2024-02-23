import 'package:flutter/material.dart';
import 'package:wave/common/const/colors.dart';
import 'package:wave/user/component/my_page_components.dart';
import 'package:wave/user/model/user_model.dart';
import 'package:wave/user/component/show_confirmation_dialog.dart';

// UserModel과 관련된 부분은 적절한 모델로 교체하세요.
class MyPageUserCard extends StatelessWidget {
  final UserModel user;
  final VoidCallback onLogout;

  const MyPageUserCard({
    Key? key,
    required this.user,
    required this.onLogout,
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
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
              OutlinedButton(
                onPressed: () => showConfirmationDialog(
                  context,
                  'Do you want to logout?',
                  'You will be returned to the login screen.',
                  onLogout,
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white, width: 1.2),
                  minimumSize: const Size(80, 30),
                ),
                child: const Text('Log out', style: TextStyle(color: Colors.white, fontSize: 10)),
              ),
            ],
          ),
          const SizedBox(height: 35),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF242424), // 내부 박스 색상 변경
              borderRadius: BorderRadius.circular(15),
            ),
            child: buildInfoSection(
                user.totalWave, user.donationCountryCnt),
          )
        ],
      ),
    );
  }
}
