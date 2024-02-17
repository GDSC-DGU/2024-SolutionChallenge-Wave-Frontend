import 'package:json_annotation/json_annotation.dart';
import 'package:wave/common/model/common_response.dart';
import 'package:wave/country/model/search_country_model.dart';

import 'donate_country_model.dart';

part 'search_countries_response.g.dart';

@JsonSerializable()
class SearchCountriesResponse extends CommonResponse {
  final List<SearchCountryModel>? data;

  SearchCountriesResponse({
    required bool success,
    this.data,
    dynamic error,
  }) : super(success: success, error: error);

  factory SearchCountriesResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchCountriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchCountriesResponseToJson(this);
}