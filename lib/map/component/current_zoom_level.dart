import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:wave/common/const/colors.dart';

MapDataLabelSettings getDataLabelSettings(double currentZoomLevel) {
  if (currentZoomLevel >= 8) {
    return const MapDataLabelSettings(
      overflowMode: MapLabelOverflow.visible,
      textStyle: TextStyle(
        fontFamily: 'HelveticaNeue',
        color: MAP_COUNTRY_COLOR,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
    );
  } else if (currentZoomLevel >= 4) {
    return const MapDataLabelSettings(
      overflowMode: MapLabelOverflow.hide,
      textStyle: TextStyle(
        fontFamily: 'HelveticaNeue',
        color: MAP_COUNTRY_COLOR,
        fontWeight: FontWeight.w600,
        fontSize: 15,
      ),
    );
  } else {
    return const MapDataLabelSettings(
      overflowMode: MapLabelOverflow.hide,
      textStyle: TextStyle(
        fontFamily: 'HelveticaNeue',
        color: MAP_COUNTRY_COLOR,
        fontWeight: FontWeight.w600,
        fontSize: 9,
      ),
    );
  }
}
