// map_page.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:wave/common/const/colors.dart';
import 'package:wave/common/const/important_countries.dart';

class GlobalMapScreen extends StatefulWidget {
  @override
  _GlobalMapScreenState createState() => _GlobalMapScreenState();
}

class _GlobalMapScreenState extends State<GlobalMapScreen> {
  late MapShapeSource _dataSource;
  late MapZoomPanBehavior _zoomPanBehavior;
  bool _isLoading = true;
  double _currentZoomLevel = 6;

  // 변경: 리스크 레벨별 상태 관리
  bool _showLowRisk = false;
  bool _showMidRisk = false;
  bool _showHighRisk = false;

  @override
  void initState() {
    super.initState();
    _zoomPanBehavior = MapZoomPanBehavior(
      focalLatLng: MapLatLng(34.8149, 39.02),
      enableDoubleTapZooming: true,
      enablePanning: true,
      enablePinching: true,
      zoomLevel: _currentZoomLevel,
      minZoomLevel: 1,
      maxZoomLevel: 10,
    );
    print(_showLowRisk);
    _showLowRisk = true;
    print(_showLowRisk);
    _showMidRisk = true;
    _showHighRisk = true;
    _updateDataSource();
  }

  Future<void> _updateDataSource() async {
    print('now is time');
    final jsonString =
        await rootBundle.loadString('assets/maps/world_map.json');
    final jsonResponse = json.decode(jsonString);
    final features = jsonResponse['features'] as List;

    setState(() {
      _dataSource = MapShapeSource.asset(
        'assets/maps/world_map.json',
        shapeDataField: 'name',
        dataCount: features.length,
        primaryValueMapper: (int index) =>
            features[index]['properties']['name'],
        shapeColorValueMapper: (int index) =>
            _getRiskLevelColor(features[index]['properties']['name']),
        dataLabelMapper: (int index) =>
            jsonResponse['features'][index]['properties']['name'].toString(),
      );
      _isLoading = false;
    });
  }

  Color _getRiskLevelColor(String countryName) {
    if (lowRiskCountries.contains(countryName) && _showLowRisk) {
      return CAUTION_YELLO_COLOR;
    } else if (midRiskCountries.contains(countryName) && _showMidRisk) {
      return ALERT_ORANGE_COLOR;
    } else if (highRiskCountries.contains(countryName) && _showHighRisk) {
      return EMERGENCY_RED_COLOR;
    } else {
      return PRIMARY_GRAY_COLOR;
    }
  }

  MapDataLabelSettings _getDataLabelSettings() {
    if (_currentZoomLevel >= 8) {
      // 줌 레벨이 10 이상일 때
      return const MapDataLabelSettings(
        overflowMode: MapLabelOverflow.visible,
        textStyle: TextStyle(
          color: PRIMARY_BLUE_COLOR,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      );
    } else if (_currentZoomLevel >= 4) {
      // 줌 레벨이 6 이상이지만 8 미만일 때
      return const MapDataLabelSettings(
        overflowMode: MapLabelOverflow.hide,
        textStyle: TextStyle(
          color: PRIMARY_BLUE_COLOR,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      );
    } else {
      // 그 외의 경우 (줌 레벨이 6 미만일 때)
      return const MapDataLabelSettings(
        overflowMode: MapLabelOverflow.hide,
        textStyle: TextStyle(
          color: PRIMARY_BLUE_COLOR,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      );
    }
  }

  void _showCustomModal(BuildContext context, String countryName) {
    showDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        builder: (BuildContext context) {
          return Dialog(
            child: BuildCustomCard(),
          );
        });
  }

  final maxHeight =
      MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'World Conflict Map',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: maxHeight * 0.9,
              child: Stack(
                children: [
                  SfMaps(
                    layers: [
                      MapShapeLayer(
                        onSelectionChanged: (int index) {
                          print(_dataSource.dataLabelMapper!(index));
                          setState(() {
                            final String countryName =
                                _dataSource.dataLabelMapper!(index);
                            if (importantCountries.contains(countryName)) {
                              _showCustomModal(context, countryName);
                            }
                          });
                        },
                        source: _dataSource,
                        zoomPanBehavior: _zoomPanBehavior,
                        showDataLabels: true,
                        dataLabelSettings: _getDataLabelSettings(),
                        onWillZoom: (MapZoomDetails details) {
                          setState(() {
                            if (details.newZoomLevel != null) {
                              print(
                                  "Zoom Level before zoom: ${details.previousZoomLevel}");
                              print(
                                  "Zoom Level after zoom: ${details.newZoomLevel}");
                              _currentZoomLevel = details.newZoomLevel!;
                              _updateDataSource();
                            }
                          });
                          return true;
                        },
                        selectionSettings: MapSelectionSettings(
                          color: Colors.indigo,
                          strokeColor: Colors.indigo,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    left: 10,
                    child: Row(
                      children: [
                        _riskLevelButton(
                            'Emergency', _showHighRisk, PRIMARY_BLUE_COLOR),
                        _riskLevelButton(
                            'Alert', _showMidRisk, PRIMARY_BLUE_COLOR),
                        _riskLevelButton(
                            'Caution', _showLowRisk, PRIMARY_BLUE_COLOR),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _riskLevelButton(String riskLevel, bool isSelected, Color color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          print('now is time@@@@');
          setState(() {
            if (riskLevel == 'Caution') {
              _showLowRisk = !_showLowRisk;
            } else if (riskLevel == 'Alert') {
              _showMidRisk = !_showMidRisk;
            } else if (riskLevel == 'Emergency') {
              _showHighRisk = !_showHighRisk;
            }
            _updateDataSource();
          });
        },
        child: Text(riskLevel),
        style: ElevatedButton.styleFrom(
          foregroundColor: isSelected ? Colors.white : Colors.black,
          primary: isSelected ? color : PRIMARY_GRAY_COLOR,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
Widget BuildCustomCard() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
    ),
    height: 280,
    child: Column(
      children: [
        Stack(
          children: [
            // ClipRRect(
            //   borderRadius: BorderRadius.vertical(
            //       top: Radius.circular(4.0)), // 이미지 상단 모서리만 둥글게 처리
            //   child: Image.asset(
            //     'assets/sample.png', // 이미지 경로
            //     width: 300,
            //     height: 150,
            //     fit: BoxFit.cover, // 이미지가 컨테이너에 꽉 차게
            //   ),
            // ),
            Positioned(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'EMERGENCY',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Text(
                'Help the people',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18, // 텍스트 배경 투명도 조절
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Casualties: 50,000',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  // 버튼 클릭 이벤트 처리
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[300], // 버튼 색상
                ),
                child: Text(
                  'Sending Waves',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
