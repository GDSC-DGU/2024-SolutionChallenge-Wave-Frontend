// map_page.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:wave/common/const/colors.dart';
import 'package:wave/common/layout/default_layout.dart';
import 'package:wave/country/component/donate_countries_card.dart';
import 'package:wave/country/component/modal_donate_countries_card.dart';
import 'package:wave/country/component/modal_search_countries_card.dart';
import 'package:wave/country/component/search_countries_card.dart';
import 'package:wave/country/model/donate_country_model.dart';
import 'package:wave/country/provider/donate_country_provider.dart';
import 'package:wave/country/provider/search_country_provider.dart';
import 'package:wave/loading/loading_screen.dart';
import 'package:wave/map/component/current_zoom_level.dart';
import 'package:wave/map/component/risk_level_button.dart';
import 'package:wave/map/model/important_countries_model.dart';

import '../provider/global_map_provider.dart';

/// todolist
//1. 지도 화면에 그리기
//2. 위험 국가 리스트 받아오기
//3. 위험 국가 리스트에 따라 색상 변경하기


class GlobalMapScreen extends ConsumerStatefulWidget {
  @override
  _GlobalMapScreenState createState() => _GlobalMapScreenState();
}

class _GlobalMapScreenState extends ConsumerState<GlobalMapScreen> {
  MapShapeSource? _dataSource;
 MapZoomPanBehavior? _zoomPanBehavior;
  bool _isLoading = true;
  double currentZoomLevel = 3;

  // api call로 받아온 데이터를 저장할 위험 국가 리스트 ID
  List<int> lowRiskCountriesId = [];
  List<int> midRiskCountriesId = [];
  List<int> highRiskCountriesId = [];
  List<int> importantCountriesId = [];
  List<int> donatePossibleCountriesId = [];

  // 변경: 리스크 레벨별 상태 관리
  bool _showLowRisk = false;
  bool _showMidRisk = false;
  bool _showHighRisk = false;

  List features = [];
  late List<Model> _data;
  @override
  void initState() {
    _isLoading = true;
    super.initState();
    _showHighRisk = !_showHighRisk;
    _showMidRisk = !_showMidRisk;
    _showLowRisk = !_showLowRisk;
    _updateDataSource();
    _zoomPanBehavior = MapZoomPanBehavior(
      focalLatLng: const MapLatLng(34.8149, 49.02),
      enableDoubleTapZooming: true,
      enablePanning: true,
      zoomLevel: currentZoomLevel,
      minZoomLevel: 1,
      maxZoomLevel: 12,
    );
    _data = const <Model>[
      Model('Ukraine', 10.5527, 38.5164,166),
      Model('Yemen', 48.3794, 31.1656,173),
      Model('Syria', 34.8021, 38.9968,153),
      Model('Israel', 31.0461, 34.8516, 132),
    ];
  }

  Future<void> _updateDataSource() async {
    final jsonString =
        await rootBundle.loadString('assets/maps/world_map.json');
    final jsonResponse = json.decode(jsonString);
    features = jsonResponse['features'] as List;

    setState(() {
      _dataSource = MapShapeSource.asset(
        'assets/maps/world_map.json',
        shapeDataField: 'name',
        dataCount: features.length,
        primaryValueMapper: (int index) =>
            features[index]['properties']['name'],
        shapeColorValueMapper: (int index) =>
            _getRiskLevelColor(features[index]['properties']['id']),
        dataLabelMapper: (int index) =>
            jsonResponse['features'][index]['properties']['name'],
      );
    });
  }

  Color _getRiskLevelColor(int countryId) {
    if (lowRiskCountriesId.contains(countryId) && _showLowRisk) {
      return CAUTION_YELLO_COLOR;
    } else if (midRiskCountriesId.contains(countryId) && _showMidRisk) {
      return ALERT_ORANGE_COLOR;
    } else if (highRiskCountriesId.contains(countryId) && _showHighRisk) {
      return EMERGENCY_RED_COLOR;
    } else {
      return PRIMARY_GRAY_COLOR;
    }
  }

  void _updateRiskCountriesLists(ImportantCountriesModel data) {
    // emergency, alert, caution 리스트를 업데이트하는 로직 구현
    lowRiskCountriesId = data.caution?.map((e) => e.id).toList() ?? [];
    midRiskCountriesId = data.alert?.map((e) => e.id).toList() ?? [];
    highRiskCountriesId = data.emergency?.map((e) => e.id).toList() ?? [];
    importantCountriesId = data.important ?? [];
    donatePossibleCountriesId = data.donatePossibleList ?? [];
  }

  final maxHeight =
      MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.height;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(importantCountriesProvider);
    // 데이터 로딩 상태에 따른 UI 렌더링
    if (state is ImportantCountriesLoading || _dataSource == null) {
      return const LoadingScreen();
    } else if (state is ImportantCountriesError) {
      return DefaultLayout(
        child: Center(child: Text('⭐️ Error ⭐️: ${state.message}')),
      );
    } else if (state is ImportantCountriesModel) {

      if (_isLoading || _dataSource == null) {
        _updateRiskCountriesLists(state);
        // _updateDataSource();
        _isLoading = false;
      }
    }
    return DefaultLayout(
            title: 'World Conflict Map',
            child: Container(
              height: maxHeight * 0.9,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: BlueGridPattern(), // 파란색 격자무늬를 그리는 커스텀 위젯
                  ),
                  SfMaps(
                    layers: [
                      MapShapeLayer(
                        onSelectionChanged: (int index) {
                          setState(() {
                           final importantIdx =  features[index]['properties']['id'];

                            if (donatePossibleCountriesId.contains(importantIdx)) {
                              showCustomModal(context, importantIdx,ref);

                            }else if(importantCountriesId.contains(importantIdx)){
                              showCustomSearchModal(context, importantIdx,ref);
                            }
                          });
                        },
                        initialMarkersCount: 4,
                        markerBuilder: (BuildContext context, int index) {
                          final Model model = _data[index];
                          return MapMarker(
                            latitude: model.latitude,
                            longitude: model.longitude,
                            child: GestureDetector(
                              onTap: () {
                                final countryId =  model.id;
                                if (donatePossibleCountriesId.contains(countryId)) {
                                  showCustomModal(context, countryId, ref);
                                } else if (importantCountriesId.contains(countryId)) {
                                  showCustomSearchModal(context, countryId, ref);
                                }
                              },
                              child: SvgPicture.asset(
                                'assets/icons/marker.svg',
                              ),
                            ),
                          );
                        },

                        source: _dataSource!,
                        zoomPanBehavior: _zoomPanBehavior,
                        showDataLabels: true,
                        dataLabelSettings:
                            getDataLabelSettings(currentZoomLevel),
                          onWillZoom: (MapZoomDetails details) {
                          setState(() {
                            if (details.newZoomLevel != null) {
                              currentZoomLevel = details.newZoomLevel!;
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
                        RiskLevelButton(
                          riskLevel: 'Caution',
                          isSelected: _showLowRisk,
                          color: PRIMARY_BLUE_COLOR,
                          onPressed: () {
                            setState(() {
                              _showLowRisk = !_showLowRisk;
                              _updateDataSource();
                            });
                          },
                        ),
                        RiskLevelButton(
                          riskLevel: 'Emergency',
                          isSelected: _showHighRisk,
                          color: PRIMARY_BLUE_COLOR,
                          onPressed: () {
                            setState(() {
                              _showHighRisk = !_showHighRisk;
                              _updateDataSource();
                            });
                          },
                        ),
                        RiskLevelButton(
                          riskLevel: 'Alert',
                          isSelected: _showMidRisk,
                          color: PRIMARY_BLUE_COLOR,
                          onPressed: () {
                            setState(() {
                              _showMidRisk = !_showMidRisk;
                              _updateDataSource();
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

Widget BuildCustomCard(int countryId) {
  return Container(
    height: 300,
    width: 300,
    color: Colors.white,
    child: Column(
      children: [
        Text('Test'),
      ],
    ),
  );
}

void showCustomModal(BuildContext context, int countryId, WidgetRef ref) async {
  // 상태 초기화
  bool isLoaded = false;
  // 데이터 로딩 시작
  await ref.read(donateNotifierProvider.notifier).fetchDonateCountry(countryId);
  // 데이터 로딩 완료 후 다이얼로그 표시
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.white.withOpacity(0.3), // 반투명한 흰색 배경
    builder: (BuildContext context) {
      // Provider를 통해 최신 상태를 구독
      return Consumer(
        builder: (context, ref, _) {
          final donateNotifier = ref.watch(donateNotifierProvider);
          // 데이터 로딩 여부 확인
          if (!isLoaded && donateNotifier.donateCountry != null) {
            // 데이터 로딩 완료 상태로 변경
            isLoaded = true;
          }
          // 로딩 상태에 따라 UI 분기
          if (!isLoaded) {
            return const Center(child: CircularProgressIndicator(color: PRIMARY_BLUE_COLOR));
          } else {
            return Dialog(
              child: ModalDonateCountryCard.fromModel(
                model: donateNotifier.donateCountry!,
                isDetail: false, // 상세 페이지용 카드로 표시
              ),
            );
          }
        },
      );
    },
  );
}

void showCustomSearchModal(BuildContext context, int countryId, WidgetRef ref) async {
  // 상태 초기화
  bool isLoaded = false;
  // 데이터 로딩 시작
  await ref.read(searchNotifierProvider.notifier).fetchSearchCountry(countryId);
  // 데이터 로딩 완료 후 다이얼로그 표시
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.white.withOpacity(0.3), // 반투명한 흰색 배경
    builder: (BuildContext context) {
      // Provider를 통해 최신 상태를 구독
      return Consumer(
        builder: (context, ref, _) {
          final searchNotifier = ref.watch(searchNotifierProvider);
          // 데이터 로딩 여부 확인
          if (!isLoaded && searchNotifier.state == SearchState.loaded) {
            // 데이터 로딩 완료 상태로 변경
            isLoaded = true;
          }
          // 로딩 상태에 따라 UI 분기
          if (!isLoaded) {
            return const Center(child: CircularProgressIndicator(color: PRIMARY_BLUE_COLOR));
          } else {
            return Dialog(
              child: ModalSearchCountryCard.fromModel(
                model: searchNotifier.searchCountry!,
                isDetail: false, // 상세 페이지용 카드로 표시
              ),
            );
          }
        },
      );
    },
  );
}

class BlueGridPattern extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GridPainter(),
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = PRIMARY_BLUE_COLOR.withOpacity(0.5) // 파란색 격자무늬 색상 설정
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    double gridSpace = 155; // 격자 간격 설정
    for (double i = 70; i < size.width; i += gridSpace) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = -100; i < size.height; i += gridSpace) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class Model {
  const Model(this.country, this.latitude, this.longitude, this.id);

  final String country;
  final double latitude;
  final double longitude;
  final int id;
}



