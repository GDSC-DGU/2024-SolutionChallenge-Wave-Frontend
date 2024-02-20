import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:wave/common/const/colors.dart';
import 'package:wave/common/layout/default_layout.dart';
import 'package:xml/xml.dart' as xml;
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:xml/xml.dart';
import 'package:wave/map/component/border_thumb_shape.dart';

/// FF5039(빨강) 247EF4(파랑)

class Country {
  final String path;
  String color;
  final String id;

  Country({
    required this.path,
    required this.color,
    required this.id,
  });
}

class CountryPainter extends CustomPainter {
  final List<Country> countries;

  CountryPainter({required this.countries});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path allPaths = Path(); // 모든 경로를 저장할 Path 객체

    for (var country in countries) {
      // 각 국가의 경로를 Path 객체로 변환하고 allPaths에 추가
      var path = parseSvgPathData(country.path);
      allPaths.addPath(path, Offset.zero); // Offset.zero를 사용하여 원본 위치에 경로 추가
    }

    // 모든 경로를 포함하는 allPaths의 경계를 계산
    Rect bounds = allPaths.getBounds();

    // 캔버스의 중앙과 SVG의 중앙 사이의 차이를 계산하여 SVG를 캔버스 중앙에 배치
    double offsetX = size.width / 2 - bounds.center.dx;
    double offsetY = size.height / 2 - bounds.center.dy;

    canvas.translate(offsetX, offsetY); // 캔버스 시작 위치를 조정

    // 조정된 위치에서 모든 경로를 그림
    for (var country in countries) {
      paint.color = Color(int.parse("0xFF${country.color}"));
      var path = parseSvgPathData(country.path);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class WaveSelectScreen extends StatefulWidget {
  static String get routeName => 'waveSelect';

  final String selectedCountry;

  WaveSelectScreen({Key? key, required this.selectedCountry}) : super(key: key);

  @override
  _WaveSelectScreenState createState() => _WaveSelectScreenState();
}

class _WaveSelectScreenState extends State<WaveSelectScreen> {
  double _sliderValue = 0;
  List<Country> _countries = [];

  @override
  void initState() {
    super.initState();
    _loadSvgImage('assets/images/${widget.selectedCountry.toLowerCase()}.svg');
  }

  Future<void> _loadSvgImage(String svgImage) async {
    final String svgContent = await rootBundle.loadString(svgImage);
    final document = XmlDocument.parse(svgContent);
    final paths = document.findAllElements('path');
    final localCountries = paths.map((node) {
      return Country(
        id: node.getAttribute('id') ?? '',
        path: node.getAttribute('d') ?? '',
        color: node.getAttribute('fill')?.replaceAll('#', '') ?? 'FF5039',
      );
    }).toList();

    // Sort the countries list based on the numeric part of the id
    localCountries.sort((a, b) {
      int idA = int.parse(a.id.replaceAll(RegExp(r'[^0-9]'), ''));
      int idB = int.parse(b.id.replaceAll(RegExp(r'[^0-9]'), ''));
      return idA.compareTo(idB);
    });

    setState(() {
      print('naya');
      _countries = localCountries;
      print('총나라 개수: ${_countries.length}');
    });
  }

  void _updateColors(double value) {
    int index = value.toInt();

    for (int i = 0; i <= index; i++) {
      _countries[i].color = '247EF4'; // 파란색
    }
    if (value == 0) {
      _countries[0].color = 'FF5039';
    }

    for (int i = index + 1; i < _countries.length; i++) {
      // 여기를 index에서 index + 1로 변경
      _countries[i].color = 'FF5039'; // 빨간색
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // 금액을 문자열로 변환하는 함수
    String _formattedAmount(double value) {
      return "\$${(value * (1000 / _countries.length)).toStringAsFixed(0)}";
    }

    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // 전체 컬럼을 화면 중앙으로
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 180),
            child: Expanded(
              child: Center(
                child: CustomPaint(
                  painter: CountryPainter(countries: _countries),
                ),
              ),
            ),
          ),
          _sliderValue == 0
              ? Text("Your waves can protect them!") // 0달러일 때 텍스트 표시
              : Text("You saved ${_sliderValue.toInt() + 1} region!"),
          SizedBox(height: 15), // 슬라이더와 버튼 사이의 간격
          Text(
            _formattedAmount(_sliderValue),
            style: TextStyle(
              color: Colors.black.withOpacity(0.9),
              fontWeight: FontWeight.w700,
              fontSize: 33.5,
            ),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 28.0,
              trackShape: RoundedRectSliderTrackShape(),
              activeTrackColor: PRIMARY_BLUE_COLOR,
              inactiveTrackColor: Colors.grey[100],
              thumbShape: CircleThumbShape(thumbRadius: 13),
              thumbColor: Colors.white,
              tickMarkShape: RoundSliderTickMarkShape(),
              inactiveTickMarkColor: Colors.white,
              valueIndicatorShape: PaddleSliderValueIndicatorShape(), //
              valueIndicatorColor: Colors.white,
            ),
            child: Slider(
              min: 0,
              max: _countries.isNotEmpty ? _countries.length.toDouble()-1  : 1.0,
              value: _sliderValue,
              onChanged: (value) {
                setState(() {
                  print('slider value: $value');
                  _sliderValue = value;
                  _updateColors(_sliderValue);
                });
              },
            ),
          ),
          SizedBox(height: 20), // 슬라이더와 버튼 사이의 간격
          ElevatedButton(
            onPressed: () {
              // 'Next' 버튼이 눌렸을 때의 액션
            },
            child: Text(
              'Next',
              style: TextStyle(
                color: Colors.black.withOpacity(0.9),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFFE2E2E8),
              fixedSize: Size(353, 62),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // 여기에서 borderRadius 설정
              ),
            ),
          ),
          SizedBox(height: 100), // 슬라이더와 버튼 사이의 간격
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Sending waves to ${widget.selectedCountry}',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black.withOpacity(0.9),
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
