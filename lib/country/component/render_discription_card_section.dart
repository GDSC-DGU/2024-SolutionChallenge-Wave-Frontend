import 'dart:async';
import 'package:flutter/material.dart';
import '../../discription/view/discription_screen.dart';

class DescriptionCardSlider extends StatefulWidget {
  DescriptionCardSlider({Key? key}) : super(key: key);

  @override
  _DescriptionCardSliderState createState() => _DescriptionCardSliderState();
}

class _DescriptionCardSliderState extends State<DescriptionCardSlider> {
  final List<String> imagePaths = [
    'assets/images/discriptionCard1.png',
    'assets/images/discriptionCard2.png',
    'assets/images/discriptionCard3.png',
  ];
  final PageController _pageController = PageController(viewportFraction: 1);
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (_currentPage < imagePaths.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 700),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // 화면 전체 너비 가져오기

    return Column(
      children: [
        Container(
          width: 353,
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            itemCount: imagePaths.length,
            itemBuilder: (context, index) {
              return Padding( // 여기에 패딩 추가
                padding: const EdgeInsets.symmetric(horizontal: 10), // 좌우 간격 설정
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DiscriptionScreen(),
                    ),
                  ),
                  child: Image.asset(
                    imagePaths[index],
                    width: 353,
                    height: 200,
                  ),
                ),
              );
            },
            onPageChanged: (int index) {
              setState(() {
                _currentPage = index;
              });
            },
          ),
        ),
        SizedBox(height: 0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(imagePaths.length, (index) {
            return Container(
              width: 7,
              height: 7,
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index ? Color(0xFF545454) : Color(0xFFD9D9D9),
              ),
            );
          }),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
