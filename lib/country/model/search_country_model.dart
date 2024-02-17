import 'package:json_annotation/json_annotation.dart';

import '../../common/model/i_model_with_id.dart';
import '../../common/utils/data_utils.dart';

part 'search_country_model.g.dart';

@JsonSerializable()
class SearchCountryModel implements IModelWithId {
  final String category;
  final String mainTitle;
  final String subTitle;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String image;
  final int views;
  final int id;

  SearchCountryModel({
    required this.category,
    required this.mainTitle,
    required this.subTitle,
    required this.image,
    required this.views,
    required this.id,
  });

  factory SearchCountryModel.fromJson(Map<String, dynamic> json) =>
      _$SearchCountryModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchCountryModelToJson(this);
}