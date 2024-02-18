import 'package:json_annotation/json_annotation.dart';
import 'package:wave/common/model/common_response.dart';
import 'donate_countries_data.dart'; // 수정된 부분: DonateCountryModel 대신 CountriesData를 사용

part 'donate_countries_response.g.dart';

@JsonSerializable()
class DonateCountriesResponse extends CommonResponse {
  final DonateCountriesData? data; // 수정된 부분: List<DonateCountryModel>? 에서 CountriesData? 로 변경

  DonateCountriesResponse({
    required bool success,
    this.data,
    dynamic error,
  }) : super(success: success, error: error);

  factory DonateCountriesResponse.fromJson(Map<String, dynamic> json) =>
      _$DonateCountriesResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DonateCountriesResponseToJson(this);
}
