import 'package:json_annotation/json_annotation.dart';
import 'package:wave/common/model/common_response.dart';

part 'donate_country_response.g.dart';

@JsonSerializable()
class DonateCountryResponse extends CommonResponse {
  final DonateCountryModel? data;

  DonateCountryResponse({
    required bool success,
    this.data,
    dynamic error,
  }) : super(success: success, error: error);

  factory DonateCountryResponse.fromJson(Map<String, dynamic> json) =>
      _$DonateCountryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DonateCountryResponseToJson(this);
}

@JsonSerializable()
class DonateCountryModel {
  final String category;
  final String mainTitle;
  final String subTitle;
  final String image;
  final int allWave;
  final int lastWave;
  final int casualties;
  final int id;

  DonateCountryModel({
    required this.category,
    required this.mainTitle,
    required this.subTitle,
    required this.image,
    required this.allWave,
    required this.lastWave,
    required this.casualties,
    required this.id,
  });

  factory DonateCountryModel.fromJson(Map<String, dynamic> json) =>
      _$DonateCountryModelFromJson(json);
}
