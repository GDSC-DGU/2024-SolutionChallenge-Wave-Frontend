

import 'package:json_annotation/json_annotation.dart';

part 'countries_response.g.dart';

@JsonSerializable()
class CountriesResponse {
  final bool success;
  final String error;
  final ImportantCountriesModel data;

  CountriesResponse({
    required this.success,
    required this.error,
    required this.data,
  });

  factory CountriesResponse.fromJson(Map<String, dynamic> json) =>
      _$CountriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CountriesResponseToJson(this);
}

@JsonSerializable()
class ImportantCountriesModel {
  final List<ImportantCountryModel> emergency;
  final List<ImportantCountryModel> alert;
  final List<ImportantCountryModel> caution;

  ImportantCountriesModel({
    required this.emergency,
    required this.alert,
    required this.caution,
  });

  factory ImportantCountriesModel.fromJson(Map<String, dynamic> json) =>
      _$ImportantCountriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImportantCountriesModelToJson(this);
}

@JsonSerializable()
class ImportantCountryModel {
  final int id;
  final bool isPossible;

  ImportantCountryModel({
    required this.id,
    required this.isPossible,
  });

  factory ImportantCountryModel.fromJson(Map<String, dynamic> json) =>
      _$ImportantCountryModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImportantCountryModelToJson(this);
}