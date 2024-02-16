import 'package:json_annotation/json_annotation.dart';

import '../../common/model/i_model_with_id.dart';

part 'search_countries_model.g.dart';

@JsonSerializable()
class SearchCountriesModel implements IModelWithId {
  final String category;
  final String mainTitle;
  final String subTitle;
  final String image;
  final int views;
  final int id;

  SearchCountriesModel({
    required this.category,
    required this.mainTitle,
    required this.subTitle,
    required this.image,
    required this.views,
    required this.id,
  });

  factory SearchCountriesModel.fromJson(Map<String, dynamic> json) =>
      _$SearchCountriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchCountriesModelToJson(this);
}