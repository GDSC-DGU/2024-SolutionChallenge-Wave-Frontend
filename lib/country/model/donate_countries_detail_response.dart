import 'package:json_annotation/json_annotation.dart';
import 'package:wave/common/model/common_response.dart';

import 'donate_countries_detail_model.dart';

part 'donate_countries_detail_response.g.dart';

@JsonSerializable()
class DonateCountriesDetailResponse extends CommonResponse {
  final DonateCountriesDetailModel? data;

  DonateCountriesDetailResponse({
    required bool success,
    this.data,
    dynamic error,
  }) : super(success: success, error: error);

  factory DonateCountriesDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$DonateCountriesDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DonateCountriesDetailResponseToJson(this);
}