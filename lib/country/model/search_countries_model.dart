import 'package:json_annotation/json_annotation.dart';

part 'search_countries_model.g.dart';

@JsonSerializable()
class SearchCountriesModel {
  final String category;
  final String mainTitle;
  final String subTitle;
  final String image;
  final int views;

  SearchCountriesModel({
    required this.category,
    required this.mainTitle,
    required this.subTitle,
    required this.image,
    required this.views,
  });

  factory SearchCountriesModel.fromJson(Map<String, dynamic> json) =>
      _$SearchCountriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchCountriesModelToJson(this);
}