import 'package:json_annotation/json_annotation.dart';
import 'package:wave/common/model/common_response.dart';

import 'donate_country_model.dart';

part 'donate_countries_response.g.dart';

@JsonSerializable()
class DonateCountriesResponse extends CommonResponse {
  final List<DonateCountryModel>? data;

  DonateCountriesResponse({
    required bool success,
    this.data,
    dynamic error,
  }) : super(success: success, error: error);

  factory DonateCountriesResponse.fromJson(Map<String, dynamic> json) =>
      _$DonateCountriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DonateCountriesResponseToJson(this);
}