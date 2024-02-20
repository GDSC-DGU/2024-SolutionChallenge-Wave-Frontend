import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wave/main.dart';

import '../common/layout/default_layout.dart';
import '../user/view/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  static String get routeName => 'onboarding';
  final bool showAppBar; // AppBar를 표시할지 결정하는 인자

  // 생성자에서 showAppBar를 받도록 설정합니다.
  OnboardingScreen({Key? key, this.showAppBar = false}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    prefs.setBool('isFirstRun', false); // 앱이 최초로 실행되었는지 여부를 확인후, 최초일떄만 온보딩 보여주기(물론 마이페이지에서 볼 수도 있음)
    super.initState();
  }

  // 타이틀과 내용
  final List<Map<String, String>> pageData = [
    {
      'title': 'We are a wave',
      'content': 'Create positive ripples in the world in the world.',
    },
    {
      'title': 'Our Goals',
      'content': 'We remind people of the severity of war and provide solutions to help refugees through donations.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    print('Is AppBar supposed to show? ${widget.showAppBar}');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: widget.showAppBar // showAppBar 인자에 따라 AppBar를 표시할지 결정
          ? _buildAppBar()
          : null,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 50), // 인디케이터 공간 확보
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pageData[_currentPage]['title'] ?? '',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          pageData[_currentPage]['content'] ?? '',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Image.asset('assets/images/onBoardingImage1.png'),
                      Image.asset('assets/images/onBoardingImage2.png'),
                    ],
                  ),
                ),
                // 인디케이터 고정
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(2, (index) => _buildIndicator(index)),
                ),
                SizedBox(height: 20), // 인디케이터와 화면 하단 간의 간격 추가
              ],
            ),
          ),
          if (!widget.showAppBar) // showAppBar가 false일 때만 Skip 버튼을 보여줌
            Positioned(
            top: 50.0,
            left: 8.0,
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.transparent, // 배경을 투명하게 설정
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: Color(0xFF247EF4), // 지정된 색상으로 텍스트 색상 설정
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 6.0),
      height: 10.0,
      width: 10.0,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'About Wave',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black.withOpacity(0.9),
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context),
        iconSize: 24,
      ),
    );
  }


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}