import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:wave/common/const/colors.dart';
import 'package:wave/common/layout/default_layout.dart';
import 'package:xml/xml.dart' as xml;
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:xml/xml.dart';

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
    for (var country in countries) {
      // 각 국가의 color 속성에서 색상 값을 파싱하여 Paint 객체에 적용
      paint.color = Color(int.parse("0xFF${country.color}"));

      // parseSvgPathData를 사용하여 SVG 경로 데이터를 Path 객체로 변환
      var path = parseSvgPathData(country.path);

      // 변환된 Path 객체를 캔버스에 그림
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class WaveSelectScreen extends StatefulWidget {
  @override
  _WaveSelectScreenState createState() => _WaveSelectScreenState();
}

class _WaveSelectScreenState extends State<WaveSelectScreen> {
  double _sliderValue = 0;
  List<Country> _countries = [];

  @override
  void initState() {
    super.initState();
    _loadSvgImage('assets/images/syria.svg');
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
      _countries[i].color = '247EF4';
    }
    for (int i = index + 1; i < _countries.length; i++) {
      _countries[i].color = 'FF5039';
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sending waves to country!')),
      body: Column(
        children: [
          Expanded(
            child: CustomPaint(
              painter: CountryPainter(countries: _countries),
              child: Container(),
            ),
          ),
          Slider(
            min: 0, // 최소값 설정
            max: _countries.isNotEmpty
                ? _countries.length - 1
                : 1, // _countries가 로드되기 전에는 기본값 설정
            divisions: _countries.isNotEmpty ? _countries.length - 1 : 1,
            value: _sliderValue,
            onChanged: (value) {
              setState(() {
                _sliderValue = value;
                _updateColors(_sliderValue);
              });
            },
          )
        ],
      ),
    );
  }
}
