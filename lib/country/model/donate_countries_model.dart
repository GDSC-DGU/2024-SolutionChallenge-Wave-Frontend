

import 'package:json_annotation/json_annotation.dart';

part 'donate_countries_model.g.dart';

@JsonSerializable()
class DonateCountriesModel {
  final String category;
  final String mainTitle;
  final String subTitle;
  final String image;
  final int allWave;
  final int lastWave;
  final int casualties;

  DonateCountriesModel({
    required this.category,
    required this.mainTitle,
    required this.subTitle,
    required this.image,
    required this.allWave,
    required this.lastWave,
    required this.casualties,
  });

  factory  DonateCountriesModel.fromJson(Map<String, dynamic> json) =>
      _$DonateCountriesModelFromJson(json);
}