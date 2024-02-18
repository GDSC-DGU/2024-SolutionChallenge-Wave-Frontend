// map_page.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:wave/common/const/colors.dart';
import 'package:wave/common/layout/default_layout.dart';
import 'package:wave/country/component/donate_countries_card.dart';
import 'package:wave/country/provider/donate_country_provider.dart';
import 'package:wave/loading/loading_screen.dart';
import 'package:wave/map/component/current_zoom_level.dart';
import 'package:wave/map/component/risk_level_button.dart';
import 'package:wave/map/model/important_countries_model.dart';

import '../provider/global_map_provider.dart';

class GlobalMapScreen extends ConsumerStatefulWidget {
  @override
  _GlobalMapScreenState createState() => _GlobalMapScreenState();
}

class _GlobalMapScreenState extends ConsumerState<GlobalMapScreen> {
  late MapShapeSource _dataSource;
  late MapZoomPanBehavior _zoomPanBehavior;
  bool _isLoading = true;
  double currentZoomLevel = 6;

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

  @override
  void initState() {
    super.initState();
    _zoomPanBehavior = MapZoomPanBehavior(
      focalLatLng: const MapLatLng(34.8149, 39.02),
      enableDoubleTapZooming: true,
      enablePanning: true,
      enablePinching: true,
      zoomLevel: currentZoomLevel,
      minZoomLevel: 1,
      maxZoomLevel: 10,
    );
    // 중요 국가 데이터를 가져와서 초기화
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('fetching');
      // _fetchImportantCountriesDataAndInitialize();
    });
    _updateDataSource();
    print('kikiki@@@@@@@@@2');
  }

  Future<void> _updateDataSource() async {
    print('now is time');
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
      print('dataSource: $_dataSource');
    });
  }

  Color _getRiskLevelColor(int countryId) {
    print(_showMidRisk);
    print(countryId);
    if (lowRiskCountriesId.contains(countryId) && _showLowRisk) {
      print('here???');
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
    print('lowRiskCountriesId: $lowRiskCountriesId');
  }

  final maxHeight =
      MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.height;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(importantCountriesProvider);
    // 데이터 로딩 상태에 따른 UI 렌더링
    if (state is ImportantCountriesLoading || _dataSource == null) {
      return LoadingScreen();
    } else if (state is ImportantCountriesError) {
      return DefaultLayout(
        child: Center(child: Text('⭐️ Error ⭐️: ${state.message}')),
      );
    } else if (state is ImportantCountriesModel) {
      // 데이터 로딩이 완료되었을 때만 데이터 소스를 업데이트합니다.
      if (_dataSource == null || _isLoading) {
        _updateRiskCountriesLists(state);
        print('kikiki2');
        _updateDataSource();
        print('kikiki');

        _isLoading = false;
        // _showLowRisk = true;
        // _showMidRisk = true;
        // _showHighRisk = true;
      }
    }
    return _isLoading
        ? LoadingScreen()
        : DefaultLayout(
            title: 'World Conflict Map',
            child: Container(
              height: maxHeight * 0.9,
              child: Stack(
                children: [
                  SfMaps(
                    layers: [
                      MapShapeLayer(
                        onSelectionChanged: (int index) {
                          print('importantCountriesId: $importantCountriesId');
                          setState(() {
                           final importantIdx =  features[index]['properties']['id'];
                            print(importantIdx);
                            if (donatePossibleCountriesId.contains(importantIdx)) {
                              showCustomModal(context, importantIdx,ref); // 여기에서 모달을 표시
                            }else if(importantCountriesId.contains(importantIdx)){
                              print('importantIdx: $importantIdx');
                              showCustomModal(context, importantIdx,ref);
                            }
                          });
                        },
                        source: _dataSource,
                        zoomPanBehavior: _zoomPanBehavior,
                        showDataLabels: true,
                        dataLabelSettings:
                            getDataLabelSettings(currentZoomLevel),
                        onWillZoom: (MapZoomDetails details) {
                          setState(() {
                            if (details.newZoomLevel != null) {
                              print(
                                  "Zoom Level before zoom: ${details.previousZoomLevel}");
                              print(
                                  "Zoom Level after zoom: ${details.newZoomLevel}");
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

void showCustomModal(BuildContext context, int countryId, WidgetRef ref) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      // 상태 변경 요청을 비동기적으로 스케줄링합니다.
      Future.microtask(() =>
          ref.read(donateNotifierProvider.notifier).fetchDonateCountry(countryId)
      );
      return Consumer(
        builder: (context, ref, child) {
          print('counryId: $countryId');

          // DonateNotifier의 상태를 구독
          final donateNotifier = ref.read(donateNotifierProvider);
          print('nope');
          // 상태에 따른 조건부 렌더링
          if (donateNotifier.isCountryLoading) {
            // 로딩 상태인 경우 로딩 인디케이터 표시
            return const Center(
              child: CircularProgressIndicator(
                color: PRIMARY_BLUE_COLOR,
              ),
            );
          } else if (donateNotifier.donateCountry != null) {
            print('nowbrow');
            // 데이터 로드 완료된 경우 DonateCountryCard 표시
            return Dialog(
              child: DonateCountryCard.fromModel(
                model: donateNotifier.donateCountry!,
                isDetail: false, // 상세 페이지용 카드로 표시
              ),
            );
          } else {
            // 에러 처리 또는 기타 상태 처리
            return Text('Error or other state');
          }
        },
      );
    },
  );
}
