

import 'package:json_annotation/json_annotation.dart';
import 'donate_country_model.dart';

part 'donate_countries_data.g.dart';

@JsonSerializable()
class DonateCountriesData {
  final List<DonateCountryModel> countries;

  DonateCountriesData({required this.countries});

  factory DonateCountriesData.fromJson(Map<String, dynamic> json) => _$DonateCountriesDataFromJson(json);

  Map<String, dynamic> toJson() => _$DonateCountriesDataToJson(this);
}
