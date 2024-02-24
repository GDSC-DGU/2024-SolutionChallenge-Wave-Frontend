import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wave/common/const/colors.dart';
import 'package:wave/user/view/my_page_screen.dart';
import '../../map/view/global_map_screen.dart';
import 'badge_screen.dart';

class BadgeCongratsScreen extends StatelessWidget {
  final String? amount;
  final String? count;

  static const String routeName = '/bad';

  BadgeCongratsScreen({
    super.key,
    this.amount,
    this.count,
    //required this.country,
  });

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // SvgPicture.asset(
              //   'assets/images/donationCompletionImage.svg',
              //   width: 150,
              //   height: 150,
              // ),
              Image.asset(
                'assets/images/donationCompletionImage.jpeg',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 24),
              const Text(
                "Congratulations!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              if(amount != null) // amount 뱃지를 획득했을 때 띄울 텍스트
              Text(
                "You've reached a donation of \$$amount",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
              if(count != null) // count 뱃지를 획득했을 때 띄울 텍스트
                Text(
                  "You've reached $count donations",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
            ],
          ),
          Positioned(
            bottom: 90,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 31),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => BadgeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: PRIMARY_BLUE_COLOR,
                  minimumSize: const Size(353, 62),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
