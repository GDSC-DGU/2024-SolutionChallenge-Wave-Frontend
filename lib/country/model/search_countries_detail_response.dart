import 'package:json_annotation/json_annotation.dart';
import 'package:wave/common/model/common_response.dart';
import 'donate_countries_detail_model.dart';

part 'search_countries_detail_response.g.dart';

@JsonSerializable()
class SearchCountriesDetailResponse extends CommonResponse {
  final DonateCountriesDetailModel? data;

  SearchCountriesDetailResponse({
    required bool success,
    this.data,
    dynamic error,
  }) : super(success: success, error: error);

  factory SearchCountriesDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchCountriesDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchCountriesDetailResponseToJson(this);
}