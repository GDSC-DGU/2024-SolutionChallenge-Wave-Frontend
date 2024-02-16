import 'package:json_annotation/json_annotation.dart';
import 'package:wave/common/model/common_response.dart';

part 'donate_countries_response.g.dart';

@JsonSerializable()
class DonateCountriesResponse extends CommonResponse {
  final List< DonateCountriesModel>? data;

  DonateCountriesResponse({
    required bool success,
    this.data,
    dynamic error,
  }) : super(success: success, error: error);

  factory DonateCountriesResponse.fromJson(Map<String, dynamic> json) =>
      _$DonateCountriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DonateCountriesResponseToJson(this);
}

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
