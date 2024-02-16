

import 'package:json_annotation/json_annotation.dart';

part 'important_countries_model.g.dart';

@JsonSerializable()
class ImportantCountriesModel {
  final List<CountryData>? emergency;
  final List<CountryData>? alert;
  final List<CountryData>? caution;
  final List<int>? important;

  ImportantCountriesModel({
    this.emergency,
    this.alert,
    this.caution,
    this.important,
  });

  factory ImportantCountriesModel.fromJson(Map<String, dynamic> json) =>
      _$ImportantCountriesModelFromJson(json);
}

@JsonSerializable()
class CountryData {
  final int id;
  final bool isPossible;

  CountryData({
    required this.id,
    required this.isPossible,
  });

  factory CountryData.fromJson(Map<String, dynamic> json) =>
      _$CountryDataFromJson(json);
}
