import 'package:json_annotation/json_annotation.dart';
import 'package:wave/common/model/common_response.dart';

import 'donate_country_detail_model.dart';

part 'donate_country_detail_response.g.dart';

@JsonSerializable()
class DonateCountriesDetailResponse extends CommonResponse {
  final DonateCountryDetailModel? data;

  DonateCountriesDetailResponse({
    required bool success,
    this.data,
    dynamic error,
  }) : super(success: success, error: error);

  factory DonateCountriesDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$DonateCountriesDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DonateCountriesDetailResponseToJson(this);
}