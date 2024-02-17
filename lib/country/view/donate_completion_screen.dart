import 'package:flutter/material.dart';
import '../../map/view/global_map_screen.dart';

class DonateCompletionScreen extends StatefulWidget {
  const DonateCompletionScreen({Key? key}) : super(key: key);

  static const String routeName = '/donation-completion';

  @override
  State<DonateCompletionScreen> createState() => _DonateCompletionScreenState();
}

class _DonateCompletionScreenState extends State<DonateCompletionScreen> {
  bool isLoading = true; // 로딩 상태를 관리하는 변수 //TODO: 로딩 스크린 띄워 줘야할 수 도 있어서?
  static const waves = 34; //TODO: 상태관리로 가져와야함!

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/donationCompletionImage.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 24),
              const Text(
                "You're a good donor!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "$waves waves were delivered to Ukraine.", //TODO: 상태관리로 가져와야함!
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
                  //Navigator.push(context, MaterialPageRoute(builder: (_) => GlobalMapScreen())); //TODO: ProviderScope가 없어서 에러 터짐.
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF247EF4),
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
